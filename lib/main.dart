import 'package:flutter/material.dart';
import 'package:main/startupView/startup_view.dart';
import 'package:main/utils/mobile_web_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MobileWebWrapper(child: child ?? const SizedBox.shrink());
      },
      home: const StartupView(),
    );
  }
}
