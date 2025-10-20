from pydantic import BaseModel
from datetime import datetime

class ChapterBase(BaseModel):
    title: str
    description: str | None = None
    order_index: int = 1

class ChapterCreate(ChapterBase):
    course_id: int

class ChapterUpdate(ChapterBase):
    pass

class ChapterResponse(ChapterBase):
    id: int
    course_id: int
    created_at: datetime

    class Config:
        from_attributes = True
