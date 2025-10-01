import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNav;

  const BaseLayout({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNav,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNav,
    );
  }
}
