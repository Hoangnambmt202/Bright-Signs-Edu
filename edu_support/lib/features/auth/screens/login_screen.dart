import 'package:Bright_Signs/core/widgets/app_logo.dart';
import 'package:Bright_Signs/features/auth/screens/parent_signup_screen.dart';
import 'package:Bright_Signs/features/auth/screens/student_signup_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  final String role; // "parent" hoặc "student"
  const LoginScreen({super.key, required this.role});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false; // ✅ Thêm biến loading

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // ⚙️ Giả lập API call (delay 2s)
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Gọi API login thật tại đây và lấy role từ response

      if (widget.role == "student") {
        Navigator.pushReplacementNamed(context, AppRoutes.studentMain);
      } else if (widget.role == "parent") {
        Navigator.pushReplacementNamed(context, AppRoutes.parentMain);
      } else if (widget.role == "teacher") {
        Navigator.pushReplacementNamed(context, AppRoutes.teacherMain);
      }
    } catch (e) {
      // ⚠️ Hiển thị lỗi nếu cần
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đăng nhập thất bại: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isParent = widget.role == "parent";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng nhập"),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              color: isParent ? Colors.deepOrange : Colors.green,
              height: 4.0,
              width: 150,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppLogo(iconColor: isParent ? Colors.deepOrange : Colors.green),
              const SizedBox(height: 12),
              const Text("Vui lòng đăng nhập tài khoản được cấp của bạn"),
              const SizedBox(height: 24),

              // Username
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: isParent ? "Email phụ huynh" : "Mã học sinh",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.account_circle),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? "Vui lòng nhập thông tin" : null,
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Mật khẩu",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? "Vui lòng nhập mật khẩu" : null,
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isParent ? Colors.deepOrange : Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isLoading ? null : _login, // 🔒 Disable khi loading
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Đăng nhập",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),
              ),

              const SizedBox(height: 16),
              TextButton(
                onPressed: _isLoading ? null : () {}, // Disable nếu đang load
                child: const Text("Quên mật khẩu?"),
              ),

              const SizedBox(height: 24),
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Hoặc", style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                ],
              ),

              const SizedBox(height: 24),

              // Đăng nhập Google / Facebook
              Column(
                children: [
                  OutlinedButton.icon(
                    onPressed: _isLoading ? null : () {},
                    icon: const Icon(FontAwesomeIcons.google, color: Colors.red),
                    label: const Text("Đăng nhập với Google"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12 , vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: _isLoading ? null : () {},
                    icon: const Icon(FontAwesomeIcons.facebook, color: Colors.blue),
                    label: const Text("Đăng nhập với Facebook"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric( horizontal: 12,  vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        if (widget.role == "parent") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ParentSignupScreen(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StudentSignupScreen(),
                            ),
                          );
                        }
                      },
                child: RichText(
                  text: TextSpan(
                    text: "Bạn chưa có tài khoản? ",
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Đăng ký ngay",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isParent ? Colors.deepOrange : Colors.green,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
