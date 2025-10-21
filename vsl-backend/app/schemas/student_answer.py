from pydantic import BaseModel
from typing import List
from datetime import datetime

class AnswerItem(BaseModel):
    question_id: int
    selected_answer: str

class SubmitAnswersRequest(BaseModel):
    quiz_id: int
    answers: List[AnswerItem]

class QuizResultResponse(BaseModel):
    quiz_id: int
    score: float
    total_questions: int
    correct_answers: int
    created_at: datetime
