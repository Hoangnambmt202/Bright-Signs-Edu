import 'package:flutter/material.dart';
import 'package:edu_support/features/common/widgets/custom_appbar.dart';
import 'package:edu_support/features/student/models/subject.dart';
import '../student_lectures.dart';

class LectureListScreen extends StatelessWidget {
  final Subject subject;
  final Chapter chapter;

  const LectureListScreen({
    super.key,
    required this.subject,
    required this.chapter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: chapter.title,
        titleStyle: const TextStyle(
          fontSize: 18,
        ),
        showBackButton: true,
        backgroundColor: Colors.white,
        shadow: 0.1,
      ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: chapter.lectures.length,
        itemBuilder: (context, index) {
          final lecture = chapter.lectures[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: SizedBox(
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    lecture.thumbnail,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) =>
                        Container(color: Colors.grey[200]),
                  ),
                ),
              ),
              title: Text(
                lecture.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(
                Icons.play_circle_fill,
                color: Colors.blue,
                size: 32,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LecturePlayerScreen(
                      title: lecture.title,
                      videoId: lecture.videoId,
                      signVideoId: lecture.signVideoId ?? "",
                    ),
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
