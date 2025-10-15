import 'package:flutter/material.dart';

class TeacherAssignments extends StatelessWidget {
  const TeacherAssignments({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("📝 Teacher Assignments", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
