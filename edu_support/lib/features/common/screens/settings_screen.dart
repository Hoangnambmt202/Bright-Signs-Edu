
import 'package:Bright_Signs/features/common/screens/support_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool receiveNotifications = true;
  String language = "Tiếng Việt";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cài đặt"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // 🔔 Thông báo
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text("Nhận thông báo"),
            value: receiveNotifications,
            onChanged: (val) {
              setState(() => receiveNotifications = val);
              // TODO: Lưu vào SharedPreferences / Riverpod
            },
          ),

          // 🌗 Chế độ tối
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text("Chế độ tối"),
            value: isDarkMode,
            onChanged: (val) {
              setState(() => isDarkMode = val);
              // TODO: kết nối Riverpod theme provider để đổi theme app
            },
          ),

          // 🌍 Ngôn ngữ
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Ngôn ngữ"),
            subtitle: Text(language),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showLanguageDialog(context);
            },
          ),

          // 🔑 Đổi mật khẩu
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Đổi mật khẩu"),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Đi tới trang đổi mật khẩu")),
              );
            },
          ),

          // 👤 Hồ sơ cá nhân
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Hồ sơ cá nhân"),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Đi tới hồ sơ cá nhân")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: const Text("Hỗ trợ"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SupportChatScreen(),
                ),

              );
            },
          ),

          const Divider(),

          // ℹ️ Giới thiệu ứng dụng
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Giới thiệu ứng dụng"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Bright Signs - Hỗ trợ học tập",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2025 Bright Signs - Hỗ trợ học tập",
              );
            },
          ),

          // 🚪 Đăng xuất
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              "Đăng xuất",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              // TODO: Xử lý đăng xuất (clear token, chuyển về login)
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Chọn ngôn ngữ"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text("Tiếng Việt"),
              value: "Tiếng Việt",
              groupValue: language,
              onChanged: (val) {
                setState(() => language = val.toString());
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: const Text("English"),
              value: "English",
              groupValue: language,
              onChanged: (val) {
                setState(() => language = val.toString());
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
