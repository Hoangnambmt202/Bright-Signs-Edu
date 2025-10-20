from pydantic import BaseModel
from datetime import datetime
from app.schemas.user import UserShort

class CourseBase(BaseModel):
    title: str
    description: str | None = None

class CourseCreate(CourseBase):
    teacher_id: int

class CourseUpdate(CourseBase):
    pass

class CourseResponse(CourseBase):
    id: int
    teacher: UserShort | None = None
    created_at: datetime | None = None

    class Config:
        from_attributes = True
