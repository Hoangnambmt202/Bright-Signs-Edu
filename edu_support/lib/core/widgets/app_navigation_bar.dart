import 'package:flutter/material.dart';

class AppNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final List<NavigationItem> items;
  final Function(int) onTap;
  final double height;
  final Duration animationDuration;

  const AppNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onTap,
    this.height = 60,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final activeColor = const Color(0xFF2EC4B6); // xanh mint modern
    final inactiveColor = Colors.grey[500];

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: widget.height,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.3),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = index == widget.selectedIndex;

            return Expanded(
              child: GestureDetector(
                onTap: () => widget.onTap(index),
                child: AnimatedContainer(
                  duration: widget.animationDuration,
                  curve: Curves.easeInOut,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? activeColor.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: widget.animationDuration,
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder: (child, animation) {
                        // Hiệu ứng trượt nhẹ + fade
                        final offsetAnimation = Tween<Offset>(
                          begin: const Offset(0.2, 0),
                          end: Offset.zero,
                        ).animate(animation);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: isSelected
                          ? Row(
                              key: ValueKey("selected_$index"),
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  item.icon,
                                  color: activeColor,
                                  size: 22,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  item.label ?? "",
                                  style: TextStyle(
                                    color: activeColor,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          : Icon(
                              key: ValueKey("icon_$index"),
                              item.icon,
                              color: inactiveColor,
                              size: 22,
                            ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String? label;

  const NavigationItem({
    required this.icon,
    this.label,
  });
}
