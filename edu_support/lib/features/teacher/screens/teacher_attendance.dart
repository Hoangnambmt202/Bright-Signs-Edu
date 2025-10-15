import 'package:flutter/material.dart';

class TeacherAttendance extends StatelessWidget {
  const TeacherAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("✅ Teacher Attendance", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
