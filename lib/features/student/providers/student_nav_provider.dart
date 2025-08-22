import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/navigation/nav_state.dart';

final studentNavProvider =
    StateNotifierProvider<NavNotifier, NavState>((ref) => NavNotifier());
