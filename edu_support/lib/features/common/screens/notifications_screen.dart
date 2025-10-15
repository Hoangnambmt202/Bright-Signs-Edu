import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông báo"),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: 10, // ví dụ 10 thông báo
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.notifications),
            title: Text("Thông báo số ${index + 1}"),
            subtitle: Text("Chi tiết nội dung thông báo số ${index + 1}"),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Mở chi tiết thông báo ${index + 1}")),
              );
            },
          );
        },
      ),
    );
  }
}
