from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, joinedload
from app.core.database import get_db
from app.models.quiz import Quiz, Question
from app.schemas.quiz import QuizCreate
from app.schemas.response import BaseResponse
from app.core.security import require_role

router = APIRouter()

# ----- Tạo quiz -----
@router.post("/", response_model=BaseResponse)
def create_quiz(
    quiz_data: QuizCreate,
    db: Session = Depends(get_db),
    current_user=Depends(require_role(["teacher", "admin"]))
):
    quiz = Quiz(
        title=quiz_data.title,
        description=quiz_data.description,
        lesson_id=quiz_data.lesson_id
    )
    db.add(quiz)
    db.commit()
    db.refresh(quiz)

    # thêm question (nếu có)
    for q in quiz_data.questions:
        question = Question(quiz_id=quiz.id, **q.dict())
        db.add(question)
    db.commit()

    db.refresh(quiz)
    return BaseResponse(
        status="success",
        message="Tạo quiz thành công",
        data=quiz
    )

# ----- Lấy danh sách quiz theo lesson -----
@router.get("/lesson/{lesson_id}", response_model=BaseResponse)
def get_quizzes_by_lesson(
    lesson_id: int,
    db: Session = Depends(get_db),
):
    quizzes = (
        db.query(Quiz)
        .options(joinedload(Quiz.questions))
        .filter(Quiz.lesson_id == lesson_id)
        .all()
    )
    return BaseResponse(
        status="success",
        message="Danh sách quiz trong bài học",
        data=quizzes
    )

# ----- Cập nhật quiz -----
@router.put("/{quiz_id}", response_model=BaseResponse)
def update_quiz(
    quiz_id: int,
    quiz_data: QuizCreate,
    db: Session = Depends(get_db),
    current_user=Depends(require_role(["teacher", "admin"]))
):
    quiz = db.query(Quiz).filter(Quiz.id == quiz_id).first()
    if not quiz:
        raise HTTPException(status_code=404, detail="Quiz không tồn tại")

    quiz.title = quiz_data.title
    quiz.description = quiz_data.description
    db.commit()

    return BaseResponse(status="success", message="Cập nhật quiz thành công", data=quiz)

# ----- Xoá quiz -----
@router.delete("/{quiz_id}", response_model=BaseResponse)
def delete_quiz(
    quiz_id: int,
    db: Session = Depends(get_db),
    current_user=Depends(require_role(["teacher", "admin"]))
):
    quiz = db.query(Quiz).filter(Quiz.id == quiz_id).first()
    if not quiz:
        raise HTTPException(status_code=404, detail="Quiz không tồn tại")
    db.delete(quiz)
    db.commit()
    return BaseResponse(status="success", message="Xoá quiz thành công")
