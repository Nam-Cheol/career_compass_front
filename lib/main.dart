import 'package:career_compass_front/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
    home: CareerCompass(),
  )));
}

class CareerCompass extends StatelessWidget {
  const CareerCompass({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '내 직업은 무엇일까?',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
