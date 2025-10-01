import 'package:flutter/material.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ảnh đại diện + tên
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/user-avatar-default.jpg"),
            ),
            const SizedBox(height: 12),
            const Text(
              "Nguyễn Văn A",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Thông tin cá nhân
            Card(
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text("Email"),
                    subtitle: Text("nguyenvana@example.com"),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text("Số điện thoại"),
                    subtitle: Text("0123456789"),
                  ),
                  ListTile(
                    leading: Icon(Icons.cake),
                    title: Text("Ngày sinh"),
                    subtitle: Text("01/01/2008"),
                  ),
                  ListTile(
                    leading: Icon(Icons.school),
                    title: Text("Lớp"),
                    subtitle: Text("10A1"),
                  ),
                  ListTile(
                    leading: Icon(Icons.badge),
                    title: Text("Mã học sinh"),
                    subtitle: Text("HS123456"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Thông tin học tập
            Card(
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text("Điểm trung bình"),
                    subtitle: Text("8.5 / 10"),
                  ),
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text("Số môn đã học"),
                    subtitle: Text("12"),
                  ),
                  ListTile(
                    leading: Icon(Icons.emoji_events),
                    title: Text("Thành tích"),
                    subtitle: Text("Giải Nhì Toán cấp thành phố"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Nút thao tác
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text("Chỉnh sửa thông tin"),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.lock),
              label: const Text("Đổi mật khẩu"),
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                "Đăng xuất",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
