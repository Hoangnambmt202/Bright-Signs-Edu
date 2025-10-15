# app/core/security.py
from datetime import datetime, timedelta
from jose import jwt
from pwdlib import PasswordHash
from app.core.config import settings

# Khởi tạo PasswordHash (recommended => khuyến nghị thuật toán, thường Argon2)
password_hasher = PasswordHash.recommended()

# JWT config (đặt SECRET_KEY, ALGORITHM trong .env / config)
SECRET_KEY = settings.SECRET_KEY  # lưu trong .env
ALGORITHM = settings.ALGORITHM
ACCESS_TOKEN_EXPIRE_MINUTES = settings.ACCESS_TOKEN_EXPIRE_MINUTES

# Hash password
def hash_password(password: str) -> str:
    """
    Trả về chuỗi hash an toàn (đã kèm salt và params)
    """
    return password_hasher.hash(password)

# Kiểm tra password
def verify_password(plain_password: str, hashed_password: str) -> bool:
    """
    Trả về True nếu plain_password khớp với hashed_password
    """
    return password_hasher.verify(plain_password, hashed_password)


# Tạo JWT token
def create_access_token(data: dict, expires_delta: timedelta | None = None) -> str:
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES))
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
