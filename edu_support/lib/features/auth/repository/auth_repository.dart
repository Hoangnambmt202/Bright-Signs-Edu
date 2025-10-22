
import 'package:dio/dio.dart';
import 'package:Bright_Signs/core/config/api_config.dart';

class AuthRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConfig.baseUrl));

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      print('Login response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Đăng nhập thất bại');
    }
  }
}
