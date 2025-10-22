from fastapi import APIRouter, Depends, HTTPException, Query, UploadFile, File, Form
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.models.lesson import Lesson
from app.models.chapter import Chapter
from app.schemas.lesson import LessonCreate, LessonUpdate, LessonResponse
from app.schemas.response import BaseResponse
from app.models.user import User
from app.core.security import require_role
import shutil, os

router = APIRouter()

UPLOAD_DIR = "uploads/lessons"
os.makedirs(UPLOAD_DIR, exist_ok=True)

# ----- Tạo bài học -----
@router.post("/", response_model=BaseResponse)
def create_lesson(
    data: LessonCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role(["teacher", "admin"]))
):
    chapter = db.query(Chapter).filter(Chapter.id == data.chapter_id).first()
    if not chapter:
        raise HTTPException(status_code=404, detail="Chương không tồn tại")

    lesson = Lesson(**data.model_dump())
    db.add(lesson)
    db.commit()
    db.refresh(lesson)
    return BaseResponse(
        status="success",
        message="Tạo bài học thành công",
        data=LessonResponse.model_validate(lesson)
    )

# ----- Danh sách bài học trong chương -----
@router.get("/chapter/{chapter_id}", response_model=BaseResponse)
def get_lessons_by_chapter(
    chapter_id: int,
    page: int = Query(1, ge=1),
    limit: int = Query(10, ge=1, le=100),
    db: Session = Depends(get_db),
):
    total = db.query(Lesson).filter(Lesson.chapter_id == chapter_id).count()
    lessons = (
        db.query(Lesson)
        .filter(Lesson.chapter_id == chapter_id)
        .order_by(Lesson.order_index.asc())
        .offset((page - 1) * limit)
        .limit(limit)
        .all()
    )

    return BaseResponse(
        status="success",
        message=f"Danh sách bài học trong chương {chapter_id} (trang {page})",
        data={
            "total": total,
            "page": page,
            "limit": limit,
            "total_pages": (total + limit - 1) // limit,
            "lessons": [LessonResponse.model_validate(ls) for ls in lessons]
        }
    )

# ----- Upload tài liệu (PDF / video) -----
@router.post("/{lesson_id}/upload", response_model=BaseResponse)
def upload_lesson_file(
    lesson_id: int,
    file: UploadFile = File(...),
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role(["teacher", "admin"]))
):
    lesson = db.query(Lesson).filter(Lesson.id == lesson_id).first()
    if not lesson:
        raise HTTPException(status_code=404, detail="Bài học không tồn tại")

    filename = f"{lesson_id}_{file.filename}"
    filepath = os.path.join(UPLOAD_DIR, filename)

    with open(filepath, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    # Gán URL file (trong thực tế bạn có thể lưu vào S3 hoặc CDN)
    if file.filename.lower().endswith(".pdf"):
        lesson.document_url = f"/{UPLOAD_DIR}/{filename}"
    else:
        lesson.video_url = f"/{UPLOAD_DIR}/{filename}"

    db.commit()
    db.refresh(lesson)
    return BaseResponse(
        status="success",
        message="Tải file lên thành công",
        data=LessonResponse.model_validate(lesson)
    )

# ----- Cập nhật bài học -----
@router.put("/{lesson_id}", response_model=BaseResponse)
def update_lesson(
    lesson_id: int,
    data: LessonUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role(["teacher", "admin"]))
):
    lesson = db.query(Lesson).filter(Lesson.id == lesson_id).first()
    if not lesson:
        raise HTTPException(status_code=404, detail="Bài học không tồn tại")

    for key, value in data.model_dump(exclude_unset=True).items():
        setattr(lesson, key, value)
    db.commit()
    db.refresh(lesson)
    return BaseResponse(
        status="success",
        message="Cập nhật bài học thành công",
        data=LessonResponse.model_validate(lesson)
    )

# ----- Xoá bài học -----
@router.delete("/{lesson_id}", response_model=BaseResponse)
def delete_lesson(
    lesson_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role(["teacher", "admin"]))
):
    lesson = db.query(Lesson).filter(Lesson.id == lesson_id).first()
    if not lesson:
        raise HTTPException(status_code=404, detail="Bài học không tồn tại")

    db.delete(lesson)
    db.commit()
    return BaseResponse(status="success", message="Xoá bài học thành công")
