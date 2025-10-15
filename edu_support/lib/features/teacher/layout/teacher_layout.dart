
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Bright_Signs/core/base/base_layout.dart';
import 'package:Bright_Signs/features/common/widgets/custom_appbar.dart';
import 'package:Bright_Signs/features/teacher/layout/teacher_bottom_nav.dart';
import '../providers/teacher_nav_provider.dart';
import '../screens/teacher_dashboard.dart';
import '../screens/teacher_assignments.dart';
import '../screens/teacher_attendance.dart';
import '../screens/teacher_profile.dart';

class TeacherLayout extends ConsumerWidget {
  const TeacherLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(teacherNavProvider);
    final screens = const [
        TeacherDashboard(),
        TeacherAssignments(),
        TeacherAttendance(),
        TeacherProfile(),
      ];

    return BaseLayout(
      appBar: CustomAppBar(title: "ứng dụng của giáo viên"),
      body: screens[index],
      bottomNav: const TeacherBottomNav(),
    );
  }
}
