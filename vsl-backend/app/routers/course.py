# app/api/course_router.py
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy.orm import joinedload
from app.core.database import get_db
from app.models.course import Course
from app.schemas.course import CourseCreate, CourseUpdate, CourseResponse
from app.schemas.response import BaseResponse
from app.models.user import User
from app.core.security import get_current_user, require_role

router = APIRouter()

# ----- Tạo khoá học (admin / teacher) -----
@router.post("/", response_model=BaseResponse)
def create_course(
    data: CourseCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role(["admin", "teacher"]))
):
    course = Course(**data.model_dump())
    db.add(course)
    db.commit()
    db.refresh(course)
    return BaseResponse(status="success", message="Tạo khoá học thành công", data=CourseResponse.model_validate(course))

# ----- Danh sách khoá học -----
@router.get("/", response_model=BaseResponse)
def list_courses(db: Session = Depends(get_db)):
    courses = db.query(Course).options(joinedload(Course.teacher)).all()
    if not courses:
        return BaseResponse(status="error", message="Chưa có khoá học nào")
    return BaseResponse(status="success", message="Danh sách khoá học", data=[CourseResponse.model_validate(c) for c in courses])

# ----- Chi tiết khoá học -----
@router.get("/{course_id}", response_model=BaseResponse)
def get_course(course_id: int, db: Session = Depends(get_db)):
    course = db.query(Course).options(joinedload(Course.teacher)).filter(Course.id == course_id).first()
    if not course:
        return BaseResponse(status="error", message="Không tìm thấy khoá học")
    return BaseResponse(status="success", data=CourseResponse.model_validate(course))

# ----- Cập nhật khoá học -----
@router.put("/{course_id}", response_model=BaseResponse)
def update_course(
    course_id: int,
    data: CourseUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role(["admin", "teacher"]))
):
    course = db.query(Course).filter(Course.id == course_id).first()
    if not course:
        return BaseResponse(status="error", message="Không tìm thấy khoá học")

    if current_user.role == "teacher" and course.teacher_id != current_user.id:
        return BaseResponse(status="error", message="Bạn không có quyền cập nhật khoá học này")

    for field, value in data.model_dump(exclude_unset=True).items():
        setattr(course, field, value)

    db.commit()
    db.refresh(course)
    return BaseResponse(status="success", message="Cập nhật khoá học thành công", data=CourseResponse.model_validate(course))

# ----- Xoá khoá học -----
@router.delete("/{course_id}", response_model=BaseResponse)
def delete_course(
    course_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role(["admin"]))
):
    course = db.query(Course).filter(Course.id == course_id).first()
    if not course:
        return BaseResponse(status="error", message="Không tìm thấy khoá học")
    db.delete(course)
    db.commit()
    return BaseResponse(status="success", message="Xoá khoá học thành công")
