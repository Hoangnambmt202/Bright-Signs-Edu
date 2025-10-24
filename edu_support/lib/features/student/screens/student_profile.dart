import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Bright_Signs/routes/app_routes.dart';
import 'package:Bright_Signs/features/auth/providers/auth_provider.dart';

class StudentProfile extends ConsumerWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final authController = ref.read(authControllerProvider.notifier);

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
      body: authState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Lỗi: $err')),
        data: (user) {
          if (user.isEmpty) {
            return const Center(child: Text('Chưa đăng nhập'));
          }

          // ✅ helper lấy giá trị có mặc định
          String safeValue(String? value) =>
              (value == null || value.isEmpty) ? "Chưa cập nhật" : value;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Ảnh đại diện
                CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color.fromARGB(255, 40, 184, 223),
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white,
                    backgroundImage: user["avatar"] != null &&
                            (user["avatar"] as String).isNotEmpty
                        ? NetworkImage(user["avatar"])
                        : const AssetImage("assets/images/user-avatar-default.jpg")
                            as ImageProvider,
                  ),
                ),
                const SizedBox(height: 12),

                // Tên người dùng
                Text(
                  safeValue(user["name"]),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Thông tin cá nhân
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 40, 184, 223),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text("Email"),
                        subtitle: Text(safeValue(user["email"])),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: const Text("Số điện thoại"),
                        subtitle: Text(safeValue(user["phone"])),
                      ),
                      ListTile(
                        leading: const Icon(Icons.cake),
                        title: const Text("Ngày sinh"),
                        subtitle: Text(safeValue(user["birthday"])),
                      ),
                      ListTile(
                        leading: const Icon(Icons.school),
                        title: const Text("Lớp"),
                        subtitle: Text(safeValue(user["class_name"])),
                      ),
                      ListTile(
                        leading: const Icon(Icons.badge),
                        title: const Text("Mã học sinh"),
                        subtitle: Text(safeValue(user["student_code"])),
                      ),
                      ListTile(
                        leading: const Icon(Icons.badge),
                        title: const Text("Trạng thái"),
                        subtitle: Text(safeValue(user["is_active"] == true ? "Đang hoạt động" : "Không hoạt động")),
                      ),
                      ListTile(
                        leading: const Icon(Icons.badge),
                        title: const Text("vai trò"),
                        subtitle: Text(safeValue(user["role"])),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Thông tin học tập
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: Color.fromARGB(255, 40, 184, 223), // 👈 màu viền
                  width: 1.5, // 👈 độ dày viền
                ),
              ),
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
                  onPressed: () {
                    // TODO: Mở màn hình edit profile
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Chỉnh sửa thông tin"),
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Mở màn hình đổi mật khẩu
                  },
                  icon: const Icon(Icons.lock),
                  label: const Text("Đổi mật khẩu"),
                ),
                const SizedBox(height: 10),
                TextButton.icon(
                  onPressed: () async {
                    await authController.logout();
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.login,
                      arguments: "student",
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    "Đăng xuất",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
