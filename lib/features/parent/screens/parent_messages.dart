import 'package:flutter/material.dart';

class ParentMessages extends StatelessWidget {
  const ParentMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("💬 Parent Messages", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
