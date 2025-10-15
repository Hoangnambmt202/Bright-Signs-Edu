from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.models.lesson import Lesson
from app.schemas.lesson import LessonCreate, LessonResponse
from app.api.auth import get_current_user

router = APIRouter(prefix="/lessons", tags=["Lessons"])

@router.post("/", response_model=LessonResponse)
def create_lesson(data: LessonCreate, db: Session = Depends(get_db), user=Depends(get_current_user)):
    lesson = Lesson(**data.dict())
    db.add(lesson)
    db.commit()
    db.refresh(lesson)
    return lesson

@router.get("/", response_model=list[LessonResponse])
def list_lessons(db: Session = Depends(get_db)):
    return db.query(Lesson).all()
