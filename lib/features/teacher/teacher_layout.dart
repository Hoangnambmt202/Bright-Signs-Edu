import 'package:flutter/material.dart';
import '../common/layout/base_layout.dart';
import './providers/teacher_nav_provider.dart';
import 'screens/teacher_dashboard.dart';
import 'screens/teacher_assignments.dart';
import 'screens/teacher_attendance.dart';
import 'screens/teacher_profile.dart';

class TeacherLayout extends StatelessWidget {
  const TeacherLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      navProvider: teacherNavProvider,
      pages: const [
        TeacherDashboard(),
        TeacherAssignments(),
        TeacherAttendance(),
        TeacherProfile(),
      ],
      titles: const [
        "Trang chủ",
        "Bài tập",
        "Điểm danh",
        "Hồ sơ",
      ],
      icons: const [
        Icons.home,
        Icons.assignment,
        Icons.check_circle,
        Icons.person,
      ],
    );
  }
}
