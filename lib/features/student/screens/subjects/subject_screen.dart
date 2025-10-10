import 'package:flutter/material.dart';
import 'package:edu_support/features/common/widgets/custom_appbar.dart';
import '../../data/subjects_data.dart';
import 'chapter_screen.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Môn học",
        titleStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white), 
        showBackButton: false, 
        backgroundColor: Color.fromARGB(255, 40, 184, 223), 
        shadow: 0.1,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: null),
          IconButton(icon: Icon(Icons.filter_list), onPressed: null),
          IconButton(icon: Icon(Icons.question_mark_sharp), onPressed: null),
  
        ],
        ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 8,
          childAspectRatio: 0.8,
        ),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChapterScreen(subject: subject),
                ),
              );
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(subject.icon, size: 36, color: Colors.blueAccent),
                ),
                const SizedBox(height: 8),
                Text(
                  subject.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
