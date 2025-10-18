from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from fastapi import HTTPException

from app.core.database import get_db
from app.models.user import User
from app.schemas.token import Token, RefreshTokenRequest
from app.schemas.user import UserCreate,UserLogin, UserResponse
from app.core.security import hash_password, verify_password, create_access_token, create_refresh_token, decode_access_token
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
    new_user = User(email=user.email, name=user.name, password=hashed_pw, role=user.role)
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

    access_token = create_access_token({"sub": user.email})
    refresh_token = create_refresh_token(data={"sub": user.email})
    return BaseResponse(
        status="success",
        message="Đăng nhập thành công",
        data={"access_token": access_token, "refresh_token": refresh_token, "token_type": "bearer"}
    )
# =====================
# REFRESH TOKEN
# =====================
@router.post("/refresh", response_model=Token)
def refresh_token(payload: RefreshTokenRequest):
    refresh_token = payload.refresh_token
    data = decode_access_token(refresh_token)
    if data.get("type") != "refresh":
        raise HTTPException(status_code=401, detail="Invalid refresh token")

    user_email = data.get("sub")
    if not user_email:
        raise HTTPException(status_code=401, detail="Invalid token")

    access_token = create_access_token(data={"sub": user_email})
    new_refresh_token = create_refresh_token(data={"sub": user_email})
    return {"access_token": access_token, "refresh_token": new_refresh_token, "token_type": "bearer"}