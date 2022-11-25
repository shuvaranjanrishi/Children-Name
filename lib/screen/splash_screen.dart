import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:children_name/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      animationDuration: const Duration(seconds: 2),
      duration: 4000,
      splash: "assets/images/logo2.png",
      splashIconSize: 150,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.deepPurple,
      nextScreen: const HomeScreen(),
    );
  }
}

