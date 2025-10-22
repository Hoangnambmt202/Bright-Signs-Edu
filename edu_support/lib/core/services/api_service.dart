import 'package:dio/dio.dart';
import 'package:Bright_Signs/core/config/api_config.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    return await _dio.post(endpoint, data: data);
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    return await _dio.get(endpoint, queryParameters: params);
  }

  void setAuthToken(String token) {
    _dio.options.headers["Authorization"] = "Bearer $token";
  }
}
