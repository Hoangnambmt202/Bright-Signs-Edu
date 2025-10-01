import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/teacher_nav_provider.dart';

class TeacherBottomNav extends ConsumerWidget {
  const TeacherBottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(teacherNavProvider);

    return BottomNavigationBar(
      currentIndex: index,
      onTap: (value) {
        ref.read(teacherNavProvider.notifier).state = value;
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: "Courses",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}
