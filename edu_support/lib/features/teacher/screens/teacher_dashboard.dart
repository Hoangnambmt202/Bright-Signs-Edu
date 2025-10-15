import 'package:flutter/material.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("📚 Teacher Dashboard", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
