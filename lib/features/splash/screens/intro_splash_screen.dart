import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/widgets/app_logo.dart'; // logo widget của bạn
import 'onboarding_screen.dart';

class IntroSplash extends StatefulWidget {
  const IntroSplash({super.key});

  @override
  State<IntroSplash> createState() => _IntroSplashState();
}

class _IntroSplashState extends State<IntroSplash>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;

  @override
  void initState() {
    super.initState();

    // Logo scale & fade in
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    // Text fade in (delay 500ms)
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      _textController.forward();
    });

    // Điều hướng sau 3 giây
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // nền trắng tinh gọn
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo với hiệu ứng scale + fade
            ScaleTransition(
              scale: CurvedAnimation(
                parent: _logoController,
                curve: Curves.easeOutBack,
              ),
              child: FadeTransition(
                opacity: _logoController,
                child: const AppLogo(), // widget logo của bạn
              ),
            ),
            const SizedBox(height: 20),
            // Text với hiệu ứng slide + fade
            FadeTransition(
              opacity: _textController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _textController,
                    curve: Curves.easeOut,
                  ),
                ),
                // child: const Text(
                //   "Bright Signs",
                //   style: TextStyle(
                //     fontSize: 28,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.blueAccent,
                //     letterSpacing: 1.2,
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
