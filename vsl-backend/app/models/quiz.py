from sqlalchemy import Column, Integer, String, ForeignKey, Text, DateTime, func
from sqlalchemy.orm import relationship
from app.core.database import Base

class Quiz(Base):
    __tablename__ = "quizzes"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(255), nullable=False)
    description = Column(Text, nullable=True)
    lesson_id = Column(Integer, ForeignKey("lessons.id"), nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    lesson = relationship("Lesson", back_populates="quizzes")
    questions = relationship("Question", back_populates="quiz", cascade="all, delete")
    student_answers = relationship("StudentAnswer", back_populates="quiz")
    quiz_results = relationship("QuizResult", back_populates="quiz")
    progresses = relationship("Progress", back_populates="quiz", cascade="all, delete-orphan")



class Question(Base):
    __tablename__ = "questions"

    id = Column(Integer, primary_key=True, index=True)
    quiz_id = Column(Integer, ForeignKey("quizzes.id"), nullable=False)
    content = Column(Text, nullable=False)
    option_a = Column(String(255))
    option_b = Column(String(255))
    option_c = Column(String(255))
    option_d = Column(String(255))
    correct_answer = Column(String(1))  # ví dụ: "A", "B", "C", "D"

    quiz = relationship("Quiz", back_populates="questions")
