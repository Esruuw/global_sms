import 'dart:async';
import 'package:flutter/material.dart';
import 'package:main/categoriesPage/CategoriesView%20.dart';

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const CategoriesScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.5, 0.2),
            radius: 1.4,
            colors: [
              Color(0xFF9B2FD9),
              Color(0xFF5A1090),
              Color(0xFF2A0860),
              Color(0xFF0A0420),
            ],
            stops: [0.0, 0.3, 0.65, 1.0],
          ),
        ),
        child: Column(
          children: [
          const SizedBox(height: 80),

          Center(
            child: Container(
              width: 80,
              height: 5,
              color: Colors.white,
            ),
          ),

          const Spacer(),

          const Text(
            '_Chat Session',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w400,
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Container(
              width: 220,
              height: 5,
              color: Colors.white,
            ),
          ),
        ],
      ),
      )
    );
  }
}