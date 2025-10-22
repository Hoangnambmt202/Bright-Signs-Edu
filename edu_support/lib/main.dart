import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Bắt buộc khi dùng async trong main
  await dotenv.load(fileName: ".env"); // ✅ Load biến môi trường trước khi khởi tạo provider

  runApp(const ProviderScope(child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bright Signs',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: AppRoutes.introSplash, // Mở app vào splash
      routes: AppRoutes.routes,
    );
  }
}
