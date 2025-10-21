import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.database import Base, engine
from app.routers import auth, user, course, enrollment, chapter, lesson, quiz



# Tạo bảng database nếu chưa có
Base.metadata.create_all(bind=engine)

app = FastAPI(title="VSL Learning API")

origins = [
    "http://localhost",
    "http://localhost:3000",
    "http://localhost:8000",
]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
app.include_router(auth.router, prefix="/auth", tags=["auth"])
app.include_router(user.router, prefix="/users", tags=["users"])    
app.include_router(course.router, prefix="/courses", tags=["courses"])
app.include_router(enrollment.router, prefix="/enroll", tags=["enrollments"])
app.include_router(chapter.router, prefix="/chapters", tags=["chapters"])
app.include_router(lesson.router, prefix="/lessons", tags=["lessons"])
app.include_router(quiz.router, prefix="/quizzes", tags=["quizzes"])

if __name__ == "__main__":
    uvicorn.run("app.main:app", host="127.0.0.1", port=8000, reload=True)