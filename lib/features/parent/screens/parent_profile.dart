import 'package:flutter/material.dart';

class ParentProfile extends StatelessWidget {
  const ParentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("👩‍👦 Parent Profile", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
