import 'package:edu_support/features/parent/layout/parent_layout.dart';
import 'package:edu_support/features/student/layout/student_layout.dart';
import 'package:edu_support/features/teacher/layout/teacher_layout.dart';
import 'package:flutter/material.dart';
import '../features/splash/screens/splash_screen.dart';
import '../features/splash/screens/intro_splash_screen.dart'; // 👈 thêm dòng này
import '../features/auth/screens/login_screen.dart';

class AppRoutes {
  static const String introSplash = '/intro_splash';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String studentMain = '/student';
  static const String parentMain = '/parent';
  static const String teacherMain = '/teacher';

  static Map<String, WidgetBuilder> routes = {
    introSplash: (context) => const IntroSplash(),   
    splash: (context) => const SplashScreen(),
    login: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return LoginScreen(role: args);
    },
    studentMain: (context) => const StudentLayout(),
    parentMain: (context) => const ParentLayout(),
    teacherMain: (context) => const TeacherLayout(),
  };
}
