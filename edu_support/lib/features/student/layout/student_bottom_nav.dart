import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Bright_Signs/core/widgets/app_navigation_bar.dart';
import '../providers/student_nav_provider.dart';

class StudentBottomNav extends ConsumerWidget {
  const StudentBottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(studentNavIndexProvider);

    return AppNavigationBar(
      selectedIndex: index,
      onTap: (i) => ref.read(studentNavIndexProvider.notifier).state = i,
      items: const [
        NavigationItem(icon: Icons.home, label: 'Trang chủ'),
        NavigationItem(icon: Icons.menu_book, label:'Bài học'),
        NavigationItem(icon: Icons.assignment, label: 'Bài tập'),
        NavigationItem(icon: Icons.grade, label: 'Kết quả'),
      ],
    );
  }
}
