import 'package:flutter/material.dart';
import '../features/splash/screens/splash_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/home/screens/home_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return LoginScreen(role: args);
    },
    home: (context) => const HomeScreen(),
  };
}
