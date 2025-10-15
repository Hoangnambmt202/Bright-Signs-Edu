import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavState {
  final int selectedIndex;
  const NavState(this.selectedIndex);
}

class NavNotifier extends StateNotifier<NavState> {
  NavNotifier() : super(const NavState(0));

  void setIndex(int index) {
    state = NavState(index);
  }
}
