from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.models.chapter import Chapter
from app.models.course import Course
from app.schemas.chapter import ChapterCreate, ChapterResponse, ChapterUpdate
from app.schemas.response import BaseResponse
from app.models.user import User
from app.core.security import require_role

router = APIRouter()

# ----- Tạo chương mới -----
@router.post("/", response_model=BaseResponse)
def create_chapter(
    data: ChapterCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role(["teacher", "admin"]))
):
    course = db.query(Course).filter(Course.id == data.course_id).first()
    if not course:
        return BaseResponse(status="error", message="Khoá học không tồn tại")

    chapter = Chapter(**data.model_dump())
    db.add(chapter)
    db.commit()
    db.refresh(chapter)

    return BaseResponse(
        status="success",
        message="Tạo chương mới thành công",
        data=ChapterResponse.model_validate(chapter)
    )

# ----- Danh sách chương trong khoá học -----
@router.get("/course/{course_id}", response_model=BaseResponse)
def get_chapters_by_course(
    course_id: int,
    page: int = Query(1, ge=1),
    limit: int = Query(10, ge=1, le=100),
    db: Session = Depends(get_db),
):
    total = db.query(Chapter).filter(Chapter.course_id == course_id).count()
    chapters = (
        db.query(Chapter)
        .filter(Chapter.course_id == course_id)
        .order_by(Chapter.order_index.asc())
        .offset((page - 1) * limit)
        .limit(limit)
        .all()
    )

    return BaseResponse(
        status="success",
        message=f"Danh sách chương trong khoá học {course_id} (trang {page})",
        data={
            "total": total,
            "page": page,
            "limit": limit,
            "total_pages": (total + limit - 1) // limit,
            "chapters": [ChapterResponse.model_validate(ch) for ch in chapters],
        }
    )

# ----- Cập nhật chương -----
@router.put("/{chapter_id}", response_model=BaseResponse)
def update_chapter(
    chapter_id: int,
    data: ChapterUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role(["teacher", "admin"]))
):
    chapter = db.query(Chapter).filter(Chapter.id == chapter_id).first()
    if not chapter:
        raise HTTPException(status_code=404, detail="Chương không tồn tại")

    for key, value in data.model_dump(exclude_unset=True).items():
        setattr(chapter, key, value)
    db.commit()
    db.refresh(chapter)

    return BaseResponse(
        status="success",
        message="Cập nhật chương thành công",
        data=ChapterResponse.model_validate(chapter)
    )

# ----- Xoá chương -----
@router.delete("/{chapter_id}", response_model=BaseResponse)
def delete_chapter(
    chapter_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role(["teacher", "admin"]))
):
    chapter = db.query(Chapter).filter(Chapter.id == chapter_id).first()
    if not chapter:
        raise HTTPException(status_code=404, detail="Chương không tồn tại")

    db.delete(chapter)
    db.commit()

    return BaseResponse(status="success", message="Xoá chương thành công")
