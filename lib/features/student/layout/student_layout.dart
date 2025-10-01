import 'package:edu_support/core/base/base_layout.dart';
import 'package:edu_support/features/student/providers/student_nav_provider.dart';
import 'package:edu_support/features/student/screens/student_assignments.dart';
import 'package:edu_support/features/student/screens/student_dashboard.dart';
import 'package:edu_support/features/student/screens/student_grades.dart';
// import 'package:edu_support/features/student/screens/student_lectures.dart';
import 'package:edu_support/features/student/screens/student_profile.dart';
import 'package:edu_support/features/student/screens/subjects/subject_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'student_bottom_nav.dart';

class StudentLayout extends ConsumerWidget {
  const StudentLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(studentNavIndexProvider);

    final screens = const [
      StudentDashboard(),
      // StudentLectures(),
      SubjectScreen(),
      StudentAssignments(),
      StudentGrades(),
      StudentProfile(),
    ];

    return BaseLayout(
      body: screens[index],
      bottomNav: const StudentBottomNav(),
    );
  }
}
