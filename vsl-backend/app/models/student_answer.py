from sqlalchemy import Column, Integer, String, ForeignKey, Float, DateTime, func
from sqlalchemy.orm import relationship
from app.core.database import Base

class StudentAnswer(Base):
    __tablename__ = "student_answers"

    id = Column(Integer, primary_key=True, index=True)
    student_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    quiz_id = Column(Integer, ForeignKey("quizzes.id"), nullable=False)
    question_id = Column(Integer, ForeignKey("questions.id"), nullable=False)
    quiz_result_id = Column(Integer, ForeignKey("quiz_results.id"), nullable=True)  # 🔑 thêm dòng này

    selected_answer = Column(String(1), nullable=False)
    is_correct = Column(Integer, default=0)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # relationships
    student = relationship("User", back_populates="student_answers")
    quiz = relationship("Quiz", back_populates="student_answers")
    quiz_result = relationship("QuizResult", back_populates="student_answers")  
    
    
class QuizResult(Base):
    __tablename__ = "quiz_results"

    id = Column(Integer, primary_key=True, index=True)
    student_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    quiz_id = Column(Integer, ForeignKey("quizzes.id"), nullable=False)
    score = Column(Float, nullable=False)
    total_questions = Column(Integer, nullable=False)
    correct_answers = Column(Integer, nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    student = relationship("User", back_populates="quiz_results")
    quiz = relationship("Quiz", back_populates="quiz_results")

    # 🔗 thêm quan hệ với StudentAnswer
    student_answers = relationship("StudentAnswer", back_populates="quiz_result", cascade="all, delete-orphan")

