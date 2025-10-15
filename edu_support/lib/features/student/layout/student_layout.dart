import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Bright_Signs/core/base/base_layout.dart';
import 'package:Bright_Signs/features/student/providers/student_nav_provider.dart';
import 'package:Bright_Signs/features/student/screens/student_assignments.dart';
import 'package:Bright_Signs/features/student/screens/student_dashboard.dart';
import 'package:Bright_Signs/features/student/screens/student_grades.dart';
import 'package:Bright_Signs/features/student/screens/student_profile.dart';
import 'package:Bright_Signs/features/student/screens/subjects/subject_screen.dart';
import 'package:Bright_Signs/features/common/widgets/chatbot_button.dart';

import 'student_bottom_nav.dart';

class StudentLayout extends ConsumerWidget {
  const StudentLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(studentNavIndexProvider);

    final screens = const [
      StudentDashboard(),
      SubjectScreen(),
      StudentAssignments(),
      StudentGrades(),
      StudentProfile(),
    ];

    return BaseLayout(
  body: Stack(
    children: [
      screens[index],

      // Nút chatbot nổi
      const ChatbotButton(),
    ],
  ),
  bottomNav: const StudentBottomNav(),
);

  }
}
