from pydantic import BaseModel
from datetime import datetime

class LessonBase(BaseModel):
    title: str
    description: str | None = None
    order_index: int = 1
    video_url: str | None = None
    document_url: str | None = None

class LessonCreate(LessonBase):
    chapter_id: int

class LessonUpdate(LessonBase):
    pass

class LessonResponse(LessonBase):
    id: int
    chapter_id: int
    created_at: datetime

    class Config:
        from_attributes = True
