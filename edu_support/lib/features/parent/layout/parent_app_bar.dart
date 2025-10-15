import 'package:flutter/material.dart';

class ParentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ParentAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("👨‍👩‍👧 Parent View"),
      backgroundColor: Colors.purple,
      actions: [
        IconButton(
          icon: const Icon(Icons.message),
          onPressed: () {
            // TODO: mở tin nhắn phụ huynh
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
