import 'package:flutter/material.dart';

class TeacherProfile extends StatelessWidget {
  const TeacherProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("👨‍🏫 Teacher Profile", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
