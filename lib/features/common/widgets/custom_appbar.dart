import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleStyle;
  final Widget? widget;
  final bool centerTitle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Color backgroundColor;
  final double? shadow;

  const CustomAppBar({
    super.key,
    this.title = "",
    this.titleStyle,
    this.widget,
    this.showBackButton = false,
    this.centerTitle = false,
    this.onBack,
    this.actions,
    this.backgroundColor = Colors.blue,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBack ?? () => Navigator.of(context).pop(),
            )
          : null,
      title:
          widget ??
          Text(
            title,
            style:
                titleStyle ??
                const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
          ),
      centerTitle: centerTitle,
      actions: actions,
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(shadow ?? 0.5),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
