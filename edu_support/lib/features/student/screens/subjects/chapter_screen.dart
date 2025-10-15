import 'package:flutter/material.dart';
import 'package:Bright_Signs/features/common/widgets/custom_appbar.dart';
import 'package:Bright_Signs/features/student/models/subject.dart';
import 'lecture_list_screen.dart';

class ChapterScreen extends StatelessWidget {
  final Subject subject;
  const ChapterScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: subject.name,
        titleStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
        showBackButton: true,
        backgroundColor: Color.fromARGB(255, 40, 184, 223),
        shadow: 0.1,
      ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: subject.chapters.length,
        itemBuilder: (context, index) {
          final chapter = subject.chapters[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                chapter.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        LectureListScreen(subject: subject, chapter: chapter),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
