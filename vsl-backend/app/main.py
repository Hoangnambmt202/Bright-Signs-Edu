import uvicorn
from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware
from app.core.database import Base, engine, get_db
from pydantic import BaseModel
from sqlalchemy.orm import Session
from app.models.user import User

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
@app.get('/users')
def get_users(db: Session = Depends(get_db) ):
    users = db.query(User).all()
    return users


if __name__ == "__main__":
    uvicorn.run("app.main:app", host="127.0.0.1", port=8000, reload=True)