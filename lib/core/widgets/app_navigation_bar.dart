import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class AppNavigationBar extends StatelessWidget {
  final int index;
  final List<Widget> items;
  final Function(int) onTap;
  final Color backgroundColor;
  final Color color;
  final Color buttonBackgroundColor;
  final double height;

  const AppNavigationBar({
    super.key,
    required this.index,
    required this.items,
    required this.onTap,
    this.backgroundColor = Colors.transparent,
    this.color = Colors.blue,
    this.buttonBackgroundColor = Colors.blueAccent,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: index,
      backgroundColor: backgroundColor,
      color: color,
      buttonBackgroundColor: buttonBackgroundColor,
      height: height,
      items: items,
      onTap: onTap,
    );
  }
}
