import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:edu_support/core/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:edu_support/features/auth/screens/parent_signup_screen.dart';
import 'package:edu_support/features/auth/screens/student_signup_screen.dart';
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

void _login() {
  if (_formKey.currentState!.validate()) {
    // TODO: Gọi API backend login ở đây, nhận role từ response
    
    if (widget.role == "student") {
  Navigator.pushReplacementNamed(context, AppRoutes.studentMain);
} else if (widget.role == "parent") {
  Navigator.pushReplacementNamed(context, AppRoutes.parentMain);
} else if (widget.role == "teacher") {
  Navigator.pushReplacementNamed(context, AppRoutes.teacherMain);
}

  }
}


  @override
  Widget build(BuildContext context) {
    final isParent = widget.role == "parent";

    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng nhập"),
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Align(
            alignment: Alignment.centerLeft, // Căn chỉnh sang trái
            child: Container(
              color: isParent ? Colors.deepOrange : Colors.green,
              height: 4.0,
              width: 150,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppLogo(iconColor: isParent ? Colors.deepOrange : Colors.green),
              const SizedBox(height: 12),
              Text("Vui lòng đăng nhập tài khoản được cấp của bạn"),
              const SizedBox(height: 24),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: isParent ? "Email phụ huynh" : "Mã học sinh",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.account_circle),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập thông tin";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
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
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập mật khẩu";
                  }
                  return null;
                },
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
                  onPressed: _login,
                  child: const Text(
                    "Đăng nhập",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // TODO: Điều hướng tới màn hình quên mật khẩu
                },
                child: const Text("Quên mật khẩu?"),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Hoặc", style: TextStyle(color: Colors.grey)),
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Thay thế Row bằng Column để các nút xếp dọc
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Xử lý đăng nhập bằng Google
                      },
                      icon: const Icon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                      label: const Text("Đăng nhập với Google"),
                    ),
                  ),
                  const SizedBox(height: 16), // Khoảng cách giữa hai nút
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Xử lý đăng nhập bằng Facebook
                      },
                      icon: const Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                      ),
                      label: const Text("Đăng nhập với Facebook"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
    if (widget.role == "parent") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ParentSignupScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const StudentSignupScreen()),
      );
    }
  },
                child: RichText(
                  text: TextSpan(
                    text: "Bạn chưa có tài khoản? ",
                    style: TextStyle(color: Colors.black),
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