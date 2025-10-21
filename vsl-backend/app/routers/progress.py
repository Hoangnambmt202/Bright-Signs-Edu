from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import func
from app.core.database import get_db
from app.models.progress import Progress
from app.models.course import Course
from app.schemas.progress import ProgressCreate, ProgressResponse
from app.schemas.response import BaseResponse
from app.core.security import get_current_user

router = APIRouter()

# ----- Cập nhật / lưu tiến độ -----
@router.post("/", response_model=BaseResponse)
def update_progress(
    payload: ProgressCreate,
    db: Session = Depends(get_db),
    current_user=Depends(get_current_user)
):
    # Kiểm tra khóa học có tồn tại
    course = db.query(Course).filter(Course.id == payload.course_id).first()
    if not course:
        raise HTTPException(status_code=404, detail="Khoá học không tồn tại")

    # Tìm hoặc tạo mới record tiến độ
    progress = (
        db.query(Progress)
        .filter(
            Progress.student_id == current_user.id,
            Progress.course_id == payload.course_id,
            Progress.lesson_id == payload.lesson_id,
            Progress.quiz_id == payload.quiz_id
        )
        .first()
    )

    if not progress:
        progress = Progress(
            student_id=current_user.id,
            course_id=payload.course_id,
            chapter_id=payload.chapter_id,
            lesson_id=payload.lesson_id,
            quiz_id=payload.quiz_id,
            progress_percent=payload.progress_percent,
            completed=1 if payload.progress_percent >= 100 else 0
        )
        db.add(progress)
    else:
        progress.progress_percent = payload.progress_percent
        progress.completed = 1 if payload.progress_percent >= 100 else 0

    db.commit()
    db.refresh(progress)

    return BaseResponse(
        status="success",
        message="Cập nhật tiến độ học tập thành công",
        data=ProgressResponse.model_validate(progress)
    )


# ----- Xem tổng tiến độ trong khoá học -----
@router.get("/course/{course_id}", response_model=BaseResponse)
def get_course_progress(
    course_id: int,
    db: Session = Depends(get_db),
    current_user=Depends(get_current_user)
):
    progresses = (
        db.query(Progress)
        .filter(
            Progress.course_id == course_id,
            Progress.student_id == current_user.id
        )
        .all()
    )

    if not progresses:
        return BaseResponse(status="success", message="Chưa có tiến độ", data={"percent": 0})

    avg_progress = round(
        sum(p.progress_percent for p in progresses) / len(progresses), 2
    )

    return BaseResponse(
        status="success",
        message=f"Tiến độ khoá học ({avg_progress}%)",
        data={"percent": avg_progress}
    )
