import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edu_support/core/widgets/app_navigation_bar.dart';
import '../navigation/nav_state.dart';

class BaseLayout extends ConsumerWidget {
  final List<Widget> pages;
  final List<String> titles;
  final List<IconData> icons;
  final StateNotifierProvider<NavNotifier, NavState> navProvider;

  const BaseLayout({
    super.key,
    required this.pages,
    required this.titles,
    required this.icons,
    required this.navProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navState = ref.watch(navProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[navState.selectedIndex]),
        centerTitle: true,
      ),
      body: pages[navState.selectedIndex],
      bottomNavigationBar: AppNavigationBar(
        index: navState.selectedIndex,
        items: icons
            .map((icon) => Icon(icon, size: 30, color: Colors.white))
            .toList(),
        onTap: (index) =>
            ref.read(navProvider.notifier).setIndex(index),
      ),
    );
  }
}
