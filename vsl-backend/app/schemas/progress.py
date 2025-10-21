from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class ProgressCreate(BaseModel):
    course_id: int
    chapter_id: Optional[int] = None
    lesson_id: Optional[int] = None
    quiz_id: Optional[int] = None
    progress_percent: float = 0.0  # Mặc định hoàn thành 0%

class ProgressResponse(BaseModel):
    course_id: int
    progress_percent: float
    completed: int
    updated_at: datetime

    class Config:
        from_attribute = True
