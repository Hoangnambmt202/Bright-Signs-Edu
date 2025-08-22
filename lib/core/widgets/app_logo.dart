import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final Color iconColor;
  const AppLogo({super.key, this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        Image.asset(
          'assets/images/Bright_signs_logo.jpg',
          width: 100,
          height: 100,
        ),
        SizedBox(height: 8),
        Text(
          "Bright Signs",
          style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
