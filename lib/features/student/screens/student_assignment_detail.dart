import 'package:flutter/material.dart';

class StudentAssignmentDetail extends StatelessWidget {
  final Map<String, dynamic> item;
  const StudentAssignmentDetail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item["title"])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Môn học: ${item["subject"]}",
                style: const TextStyle(fontSize: 16)),
            Text("Hạn nộp: ${item["deadline"]}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text("Mô tả bài tập:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text(
                "Làm đầy đủ các bài tập trong sách bài tập từ trang 45 đến 50."),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Nộp bài
                },
                icon: const Icon(Icons.upload),
                label: const Text("Nộp bài"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
