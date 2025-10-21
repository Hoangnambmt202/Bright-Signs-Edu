from sqlalchemy import Column, Integer, String, Text, ForeignKey, DateTime
from datetime import datetime
from sqlalchemy.orm import relationship
from app.core.database import Base
class Lesson(Base):
    __tablename__ = "lessons"
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(255), nullable=False)
    description = Column(Text, nullable=True)
    chapter_id = Column(Integer, ForeignKey("chapters.id"), nullable=False)
    video_url = Column(String(255), nullable=True)
    document_url = Column(String(255), nullable=True)
    order_index = Column(Integer, default=1)
    created_at = Column(DateTime, default=datetime.now)

    chapter = relationship("Chapter", back_populates="lessons")
    quizzes = relationship("Quiz", back_populates="lesson")

