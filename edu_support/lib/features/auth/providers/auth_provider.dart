// lib/features/auth/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Bright_Signs/features/auth/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<Map<String, dynamic>>>(
      (ref) => AuthController(ref.watch(authRepositoryProvider)),
    );

class AuthController extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final AuthRepository _repository;

  AuthController(this._repository) : super(const AsyncData({}));



  Future<void> login(String email, String password) async {
  state = const AsyncLoading();
  try {
    final result = await _repository.login(email: email, password: password);
    final prefs = await SharedPreferences.getInstance();

    // Lấy dữ liệu token từ key "data"
    final data = result['data'] ?? {};
    final accessToken = data['access_token']?.toString();
    final refreshToken = data['refresh_token']?.toString();

    if (accessToken != null) {
      await prefs.setString('access_token', accessToken);
    }
   
    if (refreshToken != null) {
      await prefs.setString('refresh_token', refreshToken);
    }

    // Lấy thông tin user
    await fetchCurrentUser();
  } catch (e, st) {
    state = AsyncError(e, st);
  }
}
// get current user
  Future<void> fetchCurrentUser() async {
  state = const AsyncLoading();
  try {
    final user = await _repository.getCurrentUser();
    print(user);
    if (user == null) {
      // Không có user (ví dụ token null hoặc lỗi xác thực)
      state = const AsyncData({});
      return;
    }

    state = AsyncData(user);
  } catch (e, st) {
    state = AsyncError(e, st);
  }
}


  

  // logout user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    state = const AsyncData({});
  }
}
