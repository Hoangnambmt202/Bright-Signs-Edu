from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from datetime import timedelta

from app.core.database import get_db
from app.models.user import User
from app.schemas.user import UserCreate,UserLogin, UserResponse
from app.core.security import hash_password, verify_password, create_access_token
from app.schemas.response import BaseResponse

router = APIRouter()

# ----- ĐĂNG KÝ NGƯỜI DÙNG -----
@router.post("/register", response_model=BaseResponse)
def register(user: UserCreate, db: Session = Depends(get_db)):
    existing = db.query(User).filter(User.email == user.email).first()
    if existing:
        return BaseResponse(
            status="error",
            message="Email đã tồn tại",
            errors={"email": "Địa chỉ email này đã được đăng ký."}
        )

    hashed_pw = hash_password(user.password)
    new_user = User(email=user.email, name=user.name, password=hashed_pw)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return BaseResponse(
        status="success",
        message="Đăng ký người dùng thành công",
        data=UserResponse.model_validate(new_user)
    )

# ----- ĐĂNG NHẬP -----
@router.post("/login", response_model=BaseResponse)
def login(data: UserLogin, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.email == data.email).first()
    if not user:
        return BaseResponse(status="error", message="Email không tồn tại")

    if not verify_password(data.password, user.password):
        return BaseResponse(status="error", message="Sai mật khẩu")

    token = create_access_token({"sub": user.email})
    return BaseResponse(
        status="success",
        message="Đăng nhập thành công",
        data={"access_token": token, "token_type": "bearer"}
    )

