import 'package:flutter/material.dart';

class TeacherAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TeacherAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("👩‍🏫 Teacher Panel"),
      backgroundColor: Colors.green,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // TODO: mở cài đặt giáo viên
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
