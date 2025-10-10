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
    this.height = 70,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final activeColor = const Color(0xFF2EC4B6); // Xanh mint modern
    final inactiveColor = Colors.grey[500];

    return SafeArea(
      child: Container(
        width: double.infinity, // 🔥 Tràn toàn màn hình
        height: widget.height,

        // 🔥 Thêm decoration có viền trên
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.3),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = index == widget.selectedIndex;

            return GestureDetector(
              onTap: () => widget.onTap(index),
              child: AnimatedContainer(
                duration: widget.animationDuration,
                curve: Curves.easeInOut,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: isSelected
                    ? activeColor.withOpacity(0.1)
                    : Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedScale(
                      scale: isSelected ? 1.2 : 1.0,
                      duration: widget.animationDuration,
                      child: Icon(
                        item.icon,
                        color: isSelected ? activeColor : inactiveColor,
                        size: 21,
                      ),
                    ),
                    const SizedBox(height: 2),
                    AnimatedOpacity(
                      opacity: isSelected ? 1 : 0,
                      duration: widget.animationDuration,
                      child: Text(
                        item.label ?? "",
                        style: TextStyle(
                          color: activeColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: widget.animationDuration,
                      margin: const EdgeInsets.only(top: 4),
                      height: 3,
                      width: isSelected ? 14 : 0,
                      color: activeColor,
                    ),
                  ],
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
