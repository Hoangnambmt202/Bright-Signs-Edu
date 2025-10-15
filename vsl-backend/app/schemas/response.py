# app/schemas/response.py
from typing import Any, Optional
from pydantic import BaseModel

class BaseResponse(BaseModel):
    status: str = "success"
    message: str = ""
    data: Optional[Any] = None
    errors: Optional[Any] = None
