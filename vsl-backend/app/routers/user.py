# app/routers/user_router.py
from fastapi import APIRouter, Depends
from app.core.security import get_current_user
from sqlalchemy.orm import Session
from app.core.security import require_role
from app.schemas.user import UserResponse
from app.core.database import get_db
from app.schemas.response import BaseResponse
from app.models.user import User
from app.core.security import hash_password
from app.schemas.user import UserUpdate

router = APIRouter()

############# FOR ADMIN ##############
# GET ALL USERS
@router.get("/", response_model=BaseResponse)
def get_all_users(
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("admin")),
):
    users = db.query(User).all()
    return BaseResponse(
        status="success",
        message="Danh sách người dùng",
        data=[UserResponse.model_validate(u) for u in users],
    )

# UPDATE USER BY ADMIN
@router.put("/{user_id}", response_model=BaseResponse)
def update_user(
    user_id: int,
    data: UserUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("admin")),
):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        return BaseResponse(status="error", message="Người dùng không tồn tại")

    if data.name:
        user.name = data.name
    if data.avatar:
        user.avatar = data.avatar
    if data.password:
        user.password = hash_password(data.password)

    db.commit()
    db.refresh(user)
    return BaseResponse(
        status="success",
        message="Admin đã cập nhật thông tin người dùng",
        data=UserResponse.model_validate(user)
    )
# ADMIN DELETE USER
@router.delete("/{user_id}", response_model=BaseResponse)
def delete_user(
    user_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("admin")),
):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        return BaseResponse(status="error", message="Người dùng không tồn tại")
    db.delete(user)
    db.commit()
    return BaseResponse(status="success", message="Xoá người dùng thành công")


############ FOR USER #####
# get current user info
@router.get("/me", response_model=UserResponse)
def read_me(current_user: User = Depends(get_current_user)):
    return current_user

# update current user info
@router.put("/me", response_model=BaseResponse)
def update_me(
    data: UserUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    if data.name:
        current_user.name = data.name
    if data.avatar:
        current_user.avatar = data.avatar
    if data.password:
        current_user.password = hash_password(data.password)
    
    db.commit()
    db.refresh(current_user)
    return BaseResponse(
        status="success",
        message="Cập nhật thông tin thành công",
        data=UserResponse.model_validate(current_user)
    )
