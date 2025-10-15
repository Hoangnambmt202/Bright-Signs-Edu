from datetime import datetime, timedelta
from jose import jwt
from passlib.context import CryptContext
import hashlib
from app.core.config import settings

def hash_password(password: str) -> str:
    # Băm trước bằng SHA256 để tránh lỗi vượt 72 bytes
    hashed = hashlib.sha256(password.encode('utf-8')).hexdigest()
    return pwd_context.hash(hashed)

# Khởi tạo bcrypt context
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


# --- 🔐 Hash mật khẩu (SHA256 + bcrypt) ---
def get_password_hash(password: str) -> str:
    # Băm SHA256 trước để tránh lỗi giới hạn 72 bytes của bcrypt
    sha256_hashed = hashlib.sha256(password.encode("utf-8")).hexdigest()
    return pwd_context.hash(sha256_hashed)


def verify_password(plain_password: str, hashed_password: str) -> bool:
    # Băm SHA256 trước khi so sánh với hash bcrypt trong DB
    sha256_hashed = hashlib.sha256(plain_password.encode("utf-8")).hexdigest()
    return pwd_context.verify(sha256_hashed, hashed_password)


# --- 🔑 Tạo JWT Token ---
def create_access_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    
    encoded_jwt = jwt.encode(
        to_encode,
        settings.JWT_SECRET_KEY,
        algorithm=settings.JWT_ALGORITHM,
    )
    return encoded_jwt
