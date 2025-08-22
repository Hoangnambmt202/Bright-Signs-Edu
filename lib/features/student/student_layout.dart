import 'package:flutter/material.dart';
import '../common/layout/base_layout.dart';
import './providers/student_nav_provider.dart';
import 'screens/student_dashboard.dart';
import 'screens/student_assignments.dart';
import 'screens/student_grades.dart';
import 'screens/student_profile.dart';

class StudentLayout extends StatelessWidget {
  const StudentLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      navProvider: studentNavProvider,
      pages: const [
        StudentDashboard(),
        StudentAssignments(),
        StudentGrades(),
        StudentProfile(),
      ],
      titles: const [
        "Trang chủ",
        "Bài tập",
        "Điểm số",
        "Hồ sơ",
      ],
      icons: const [
        Icons.home,
        Icons.book,
        Icons.grade,
        Icons.person,
      ],
    );
  }
}
