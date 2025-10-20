from pydantic import BaseModel
from datetime import datetime
from app.schemas.course import CourseResponse
from app.schemas.user import UserShort

class EnrollmentBase(BaseModel):
    course_id: int

class EnrollmentCreate(EnrollmentBase):
    pass

class EnrollmentResponse(BaseModel):
    id: int
    course: CourseResponse | None = None
    created_at: datetime

    class Config:
        from_attributes = True
