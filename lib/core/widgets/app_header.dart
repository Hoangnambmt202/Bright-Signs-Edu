import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/navigation_bar_provider.dart';

class AppHeader extends ConsumerWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(navigationProvider);

    String title = switch (current) {
      MenuItem.home => "Trang chủ",
      MenuItem.task => "Bài tập",
      MenuItem.add => "Thêm bài đăng",
      MenuItem.notifications => "Thông báo",
      MenuItem.profile => "Hồ sơ",
    };

    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.blue,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
