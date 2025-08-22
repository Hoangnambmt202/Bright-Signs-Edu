import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/navigation/nav_state.dart';

final teacherNavProvider =
    StateNotifierProvider<NavNotifier, NavState>((ref) => NavNotifier());
