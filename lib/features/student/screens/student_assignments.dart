import 'package:flutter/material.dart';

class StudentAssignments extends StatelessWidget {
  const StudentAssignments({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("📝 Student Assignments", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
