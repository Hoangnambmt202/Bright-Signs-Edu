import 'package:flutter/material.dart';

class AppNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final List<NavigationItem> items;
  final Function(int) onTap;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final Color indicatorColor;
  final double height;
  final double borderRadius;
  final EdgeInsets margin;
  final Duration animationDuration;

  const AppNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onTap,
    this.backgroundColor = const Color.fromARGB(255, 40, 184, 223),
    this.activeColor = const Color.fromARGB(255, 40, 184, 223),
    // this.inactiveColor = const Color.fromARGB(255, 95, 95, 95),
    this.inactiveColor =  Colors.white,
    this.indicatorColor = const Color.fromARGB(255, 246, 246, 248),
    this.height = 65,
    this.borderRadius = 32.5,
    this.margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<AppNavigationBar> createState() => _CustomRoundedNavigationBarState();
}

class _CustomRoundedNavigationBarState extends State<AppNavigationBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _indicatorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _indicatorAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    ));
  }

  @override
  void didUpdateWidget(AppNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: widget.indicatorColor.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Animated indicator
          AnimatedBuilder(
            animation: _indicatorAnimation,
            builder: (context, child) {
              return AnimatedPositioned(
                duration: widget.animationDuration,
                curve: Curves.easeInOutCubic,
                left: _getIndicatorPosition(),
                top: 8,
                child: Container(
                  width: _getItemWidth() - 16,
                  height: widget.height - 16,
                  decoration: BoxDecoration(
                    color: widget.indicatorColor,
                    borderRadius: BorderRadius.circular(widget.borderRadius - 8),
                  ),
                ),
              );
            },
          ),
          // Navigation items
          Row(
            children: widget.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == widget.selectedIndex;
              
              return Expanded(
                child: GestureDetector(
                  onTap: () => widget.onTap(index),
                  child: Container(
                    height: widget.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedScale(
                              scale: isSelected ? 1.2 : 1.0,
                              duration: widget.animationDuration,
                              curve: Curves.easeInOutCubic,
                              child: Icon(
                                item.icon,
                                color: isSelected ? widget.activeColor : widget.inactiveColor,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (item.label != null)
                              AnimatedOpacity(
                                opacity: isSelected ? 1.0 : 0.0,
                                duration: widget.animationDuration,
                                child: Text(
                                  item.label!,
                                  style: TextStyle(
                                    color: widget.activeColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  double _getItemWidth() {
    return (MediaQuery.of(context).size.width - widget.margin.horizontal) / widget.items.length;
  }

  double _getIndicatorPosition() {
    return (widget.selectedIndex * _getItemWidth()) + 8;
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