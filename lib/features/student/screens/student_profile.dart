import 'package:flutter/material.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("👤 Student Profile", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
