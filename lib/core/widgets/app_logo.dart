import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final Color iconColor;
  const AppLogo({super.key, this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        Icon(Icons.school, size: 80, color: iconColor),
        SizedBox(height: 20),
        Text(
          "Bright Signs",
          style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
