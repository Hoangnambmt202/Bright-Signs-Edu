from sqlalchemy import Column, Integer, ForeignKey, Float, DateTime, func
from sqlalchemy.orm import relationship
from app.core.database import Base

class Progress(Base):
    __tablename__ = "progresses"

    id = Column(Integer, primary_key=True, index=True)
    student_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    course_id = Column(Integer, ForeignKey("courses.id"), nullable=False)
    chapter_id = Column(Integer, ForeignKey("chapters.id"), nullable=True)
    lesson_id = Column(Integer, ForeignKey("lessons.id"), nullable=True)
    quiz_id = Column(Integer, ForeignKey("quizzes.id"), nullable=True)

    progress_percent = Column(Float, default=0.0)
    completed = Column(Integer, default=0)  # 1: hoàn thành, 0: chưa
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())

    student = relationship("User", back_populates="progresses")
    course = relationship("Course", back_populates="progresses")
    chapter = relationship("Chapter", back_populates="progresses")
    lesson = relationship("Lesson", back_populates="progresses")
    quiz = relationship("Quiz", back_populates="progresses")
