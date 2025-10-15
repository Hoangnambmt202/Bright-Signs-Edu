from pydantic import BaseModel

class LessonBase(BaseModel):
    title: str
    content: str | None = None

class LessonCreate(LessonBase):
    pass

class LessonResponse(LessonBase):
    id: int
    class Config:
        from_attributes = True # Sử dụng from_attributes(v2) thay vì orm_mode(v1) 
