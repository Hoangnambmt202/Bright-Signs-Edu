from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.models.quiz import Quiz, Question
from app.models.student_answer import StudentAnswer, QuizResult
from app.schemas.student_answer import SubmitAnswersRequest, QuizResultResponse
from app.schemas.response import BaseResponse
from app.core.security import get_current_user

router = APIRouter()

# ----- Nộp bài và tự động chấm điểm -----
@router.post("/submit", response_model=BaseResponse)
def submit_quiz(
    payload: SubmitAnswersRequest,
    db: Session = Depends(get_db),
    current_user=Depends(get_current_user)
):
    quiz = db.query(Quiz).filter(Quiz.id == payload.quiz_id).first()
    if not quiz:
        raise HTTPException(status_code=404, detail="Quiz không tồn tại")

    # Lấy danh sách câu hỏi trong quiz
    questions = db.query(Question).filter(Question.quiz_id == quiz.id).all()
    if not questions:
        raise HTTPException(status_code=400, detail="Quiz chưa có câu hỏi")

    total = len(questions)
    correct = 0

    # Chấm điểm
    for ans in payload.answers:
        question = next((q for q in questions if q.id == ans.question_id), None)
        if not question:
            continue
        is_correct = 1 if question.correct_answer.upper() == ans.selected_answer.upper() else 0
        if is_correct:
            correct += 1

        # Lưu từng câu trả lời
        db.add(StudentAnswer(
            student_id=current_user.id,
            quiz_id=quiz.id,
            question_id=question.id,
            selected_answer=ans.selected_answer,
            is_correct=is_correct
        ))

    score = round((correct / total) * 100, 2)

    # Lưu kết quả tổng
    result = QuizResult(
        student_id=current_user.id,
        quiz_id=quiz.id,
        score=score,
        total_questions=total,
        correct_answers=correct
    )
    db.add(result)
    db.commit()

    return BaseResponse(
        status="success",
        message="Nộp bài & chấm điểm thành công",
        data=QuizResultResponse(
            quiz_id=quiz.id,
            score=score,
            total_questions=total,
            correct_answers=correct,
            created_at=result.created_at
        )
    )

# ----- Xem lại kết quả quiz -----
@router.get("/result/{quiz_id}", response_model=BaseResponse)
def get_quiz_result(
    quiz_id: int,
    db: Session = Depends(get_db),
    current_user=Depends(get_current_user)
):
    result = (
        db.query(QuizResult)
        .filter(QuizResult.quiz_id == quiz_id, QuizResult.student_id == current_user.id)
        .order_by(QuizResult.created_at.desc())
        .first()
    )
    if not result:
        raise HTTPException(status_code=404, detail="Chưa có kết quả cho quiz này")

    return BaseResponse(
        status="success",
        message="Kết quả quiz gần nhất",
        data=result
    )
