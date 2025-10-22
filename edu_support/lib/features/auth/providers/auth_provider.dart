// lib/features/auth/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Bright_Signs/features/auth/repository/auth_repository.dart';

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
      state = AsyncData(result);
      
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
