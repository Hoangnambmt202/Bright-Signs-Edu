from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime

class QuestionBase(BaseModel):
    content: str
    option_a: str
    option_b: str
    option_c: str
    option_d: str
    correct_answer: str

class QuestionCreate(QuestionBase):
    pass

class QuestionResponse(QuestionBase):
    id: int
    class Config:
        from_attribute = True

class QuizBase(BaseModel):
    title: str
    description: Optional[str] = None

class QuizCreate(QuizBase):
    lesson_id: int
    questions: Optional[List[QuestionCreate]] = []

class QuizResponse(QuizBase):
    id: int
    lesson_id: int
    created_at: datetime
    questions: List[QuestionResponse] = []
    class Config:
        from_attribute = True
