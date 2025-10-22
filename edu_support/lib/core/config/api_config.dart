import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000';
}
