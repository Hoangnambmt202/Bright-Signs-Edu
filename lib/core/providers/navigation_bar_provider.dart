import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Enum các menu item
enum MenuItem {
  home,
  task,
  grade,

}

/// Provider lưu menu hiện tại (default: home)
final navigationProvider = StateProvider<MenuItem>((ref) => MenuItem.home);
