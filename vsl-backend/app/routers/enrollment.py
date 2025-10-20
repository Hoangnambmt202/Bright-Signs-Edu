from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session, joinedload
from app.core.database import get_db
from app.models.enrollment import Enrollment
from app.models.course import Course
from app.models.user import User
from app.schemas.enrollment import EnrollmentCreate, EnrollmentResponse
from app.schemas.response import BaseResponse
from app.core.security import get_current_user, require_role

router = APIRouter()

# ----- Đăng ký khoá học -----
@router.post("/", response_model=BaseResponse)
def enroll_course(
    data: EnrollmentCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("student"))
):
    # Check course tồn tại
    course = db.query(Course).filter(Course.id == data.course_id).first()
    if not course:
        return BaseResponse(status="error", message="Khoá học không tồn tại")

    # Check đã đăng ký chưa
    existing = (
        db.query(Enrollment)
        .filter(Enrollment.student_id == current_user.id, Enrollment.course_id == data.course_id)
        .first()
    )
    if existing:
        return BaseResponse(status="error", message="Bạn đã đăng ký khoá học này rồi")

    enrollment = Enrollment(student_id=current_user.id, course_id=data.course_id)
    db.add(enrollment)
    db.commit()
    db.refresh(enrollment)
    return BaseResponse(status="success", message="Đăng ký khoá học thành công")

# ----- Huỷ đăng ký -----
@router.delete("/{course_id}", response_model=BaseResponse)
def unenroll_course(
    course_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("student"))
):
    enrollment = (
        db.query(Enrollment)
        .filter(Enrollment.student_id == current_user.id, Enrollment.course_id == course_id)
        .first()
    )
    if not enrollment:
        return BaseResponse(status="error", message="Bạn chưa đăng ký khoá học này")
    db.delete(enrollment)
    db.commit()
    return BaseResponse(status="success", message="Huỷ đăng ký khoá học thành công")

# ----- Danh sách khoá học đã đăng ký -----
@router.get("/my", response_model=BaseResponse)
def get_my_courses(
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role("student"))
):
    enrollments = (
        db.query(Enrollment)
        .options(joinedload(Enrollment.course).joinedload(Course.teacher))
        .filter(Enrollment.student_id == current_user.id)
        .all()
    )
    return BaseResponse(
        status="success",
        message="Danh sách khoá học đã đăng ký",
        data=[EnrollmentResponse.model_validate(e) for e in enrollments]
    )

# ----- Danh sách học viên trong khoá học -----
@router.get("/course/{course_id}", response_model=BaseResponse)
def get_students_in_course(
    course_id: int,
    page: int = Query(1, ge=1),
    limit: int = Query(10, ge=1, le=100),
    db: Session = Depends(get_db),
    current_user: User = Depends(require_role(["teacher", "admin"]))
):
    total = db.query(Enrollment).filter(Enrollment.course_id == course_id).count()
    enrollments = (
        db.query(Enrollment)
        .options(joinedload(Enrollment.student))
        .filter(Enrollment.course_id == course_id)
        .offset((page - 1) * limit)
        .limit(limit)
        .all()
    )

    students = [
        {
            "id": e.student.id,
            "name": e.student.name,
            "email": e.student.email,
            "joined_at": e.created_at
        }
        for e in enrollments
    ]

    return BaseResponse(
        status="success",
        message=f"Danh sách học viên trong khoá học (tổng: {len(students)})",
        data={
           "total": total,
            "page": page,
            "limit": limit,
            "total_pages": (total + limit - 1) // limit,  # tính tổng số trang
            "students": students
        }
    )
