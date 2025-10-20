# 🔆 BRIGHT SIGNS: ỨNG DỤNG HỖ TRỢ HỌC TẬP CHO NGƯỜI KHIẾM THÍNH

[![FastAPI](https://img.shields.io/badge/Backend-FastAPI-009688?style=for-the-badge&logo=fastapi)](https://fastapi.tiangolo.com/)
[![Flutter](https://img.shields.io/badge/Frontend-Flutter-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev/)
[![Database](https://img.shields.io/badge/Database-PostgreSQL-336791?style=for-the-badge&logo=postgresql)](https://www.postgresql.org/)

## 📝 Mục lục

1.  [Giới thiệu Dự án](#1-giới-thiệu-dự-án)
2.  [Tính năng Nổi bật](#2-tính-năng-nổi-bật)
3.  [Công nghệ Sử dụng](#3-công-nghệ-sử-dụng)
4.  [Cấu trúc Hệ thống](#4-cấu-trúc-hệ-thống)
5.  [Hướng dẫn Cài đặt & Chạy](#5-hướng-dẫn-cài-đặt--chạy)
    * [Backend (FastAPI)](#backend-fastapi)
    * [Frontend (Flutter)](#frontend-flutter)
6.  [Đóng góp](#6-đóng-góp)
7.  [Thông tin Liên hệ](#7-thông-tin-liên-hệ)
8.  [Giấy phép](#8-giấy-phép)

---

## 1. Giới thiệu Dự án

**Bright Signs** là một ứng dụng di động được thiết kế để trở thành công cụ học tập toàn diện, hỗ trợ cộng đồng người khiếm thính và những người muốn học ngôn ngữ ký hiệu. Mục tiêu của dự án là phá vỡ rào cản giao tiếp, cung cấp nội dung giáo dục chất lượng cao, dễ tiếp cận và được cá nhân hóa.

**Sứ mệnh:** Cung cấp một nền tảng học tập ngôn ngữ ký hiệu trực quan, miễn phí và hiệu quả, giúp người khiếm thính hòa nhập tốt hơn với xã hội và trao quyền cho họ trong giao tiếp hàng ngày.

## 2. Tính năng Nổi bật

| Tính năng | Mô tả |
| :--- | :--- |
| 🧑‍💻 **Hệ thống Quản lý Người dùng** | Đăng ký, Đăng nhập an toàn (sử dụng JWT/OAuth), Quản lý hồ sơ người dùng và tiến độ học tập. |
| 📚 **Thư viện Bài giảng Đa phương tiện** | Cung cấp các bài học ngôn ngữ ký hiệu được phân loại theo cấp độ, chủ đề (chữ cái, số, câu giao tiếp cơ bản). Nội dung bao gồm video chất lượng cao và hình ảnh minh họa. |
| 📈 **Theo dõi Tiến độ Học tập** | Ghi lại chính xác các bài học đã hoàn thành, thời gian học, và các mục tiêu đã đạt được. |
| 🧠 **Bài kiểm tra & Ôn luyện** | Các bài kiểm tra ngắn sau mỗi chương để củng cố kiến thức, với hệ thống chấm điểm và phản hồi tức thì. |
| 🔔 **Thông báo & Nhắc nhở** | Gửi thông báo đẩy (Push Notifications) để khuyến khích thói quen học tập thường xuyên. |

## 3. Công nghệ Sử dụng

Dự án được xây dựng dựa trên kiến trúc mạnh mẽ và hiện đại:

| Lĩnh vực | Công nghệ | Chi tiết |
| :--- | :--- | :--- |
| **Backend** | **FastAPI (Python)** | Xây dựng API nhanh, hiệu suất cao, với tài liệu API tự động (Swagger UI/Redoc). |
| **Database** | **PostgreSQL** | Cơ sở dữ liệu quan hệ mạnh mẽ, đáng tin cậy để lưu trữ dữ liệu người dùng, khóa học và tiến độ. |
| **Frontend** | **Flutter (Dart)** | Phát triển ứng dụng di động đa nền tảng (Android/iOS) với giao diện người dùng đẹp mắt, linh hoạt. |
| **ORM/Database Tool** | **SQLAlchemy** / **Alembic** | Quản lý kết nối cơ sở dữ liệu và di chuyển (migrations). |

## 4. Yêu cầu 

### Backend (FastAPI)

#### Yêu cầu

* Python 3.9+
* PostgreSQL Database
* `pip` và `venv`



1.  **Tạo và Kích hoạt Môi trường Ảo:**
    ```bash
    python -m venv venv
    source venv/bin/activate  # Trên Linux/macOS
    # .\venv\Scripts\activate   # Trên Windows
    ```

2.  **Cài đặt Thư viện:**
    ```bash
    pip install -r requirements.txt
    ```

3.  **Cấu hình Biến Môi trường:**
    Tạo file `.env` trong thư mục gốc và điền thông tin kết nối DB của bạn.
    ```env
    # .env
    DATABASE_URL="postgresql://user:password@host:port/dbname"
    SECRET_KEY="your_super_secret_key"
    ALGORITHM="HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES=30
    ```

4.  **Chạy Migrations (Tạo Database Schema):**
    Sử dụng Alembic (hoặc công cụ ORM tương ứng) để áp dụng các thay đổi database.
    ```bash
    alembic upgrade head
    ```

6.  **Khởi chạy Server:**
    ```bash
    uvicorn app.main:app --reload
    ```
    API sẽ chạy tại: `http://127.0.0.1:8000`
    Tài liệu API (Swagger UI): `http://127.0.0.1:8000/docs`

### Frontend (Flutter)

* **Tham khảo thư mục `bright-signs-frontend/`** để biết chi tiết về cài đặt Flutter.
* Đảm bảo rằng bạn đã cập nhật địa chỉ IP của Backend trong file cấu hình Flutter để kết nối thành công.

## 6. Đóng góp

Chúng tôi hoan nghênh mọi đóng góp để làm cho **Bright Signs** tốt hơn!

1.  Fork (phân nhánh) dự án này.
2.  Tạo một branch mới cho tính năng của bạn (`git checkout -b feature/AmazingFeature`).
3.  Commit các thay đổi của bạn (`git commit -m 'Add some AmazingFeature'`).
4.  Push lên branch (`git push origin feature/AmazingFeature`).
5.  Mở một **Pull Request (PR)**.

## 7. Thông tin Liên hệ

Người phát triển: NamGoPhim

⭐ Portfolio : https://namgophim.vercel.app

⭐ Email: nam23062002@gmail.com

⭐ Phone: +84 914 837 433 (Zalo)

⭐ Linkedin: https://www.linkedin.com/in/pham-ngoc-hoang-nam

## 8. Giấy phép

Dự án này được cấp phép theo Giấy phép **MIT**. Xem file `LICENSE` để biết thêm chi tiết.