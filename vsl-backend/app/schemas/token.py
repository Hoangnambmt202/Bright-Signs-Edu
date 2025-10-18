# app/schemas/token.py
from pydantic import BaseModel

class Token(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"

class TokenData(BaseModel):
    sub: str | None = None
    type: str | None = None
class RefreshTokenRequest(BaseModel):
    refresh_token: str