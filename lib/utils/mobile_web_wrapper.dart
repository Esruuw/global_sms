import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Constrains the app to a mobile-width viewport when running on web.
class MobileWebWrapper extends StatelessWidget {
  const MobileWebWrapper({
    super.key,
    required this.child,
    this.maxWidth = 430,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return child;
    }

    final screenSize = MediaQuery.sizeOf(context);
    final mobileWidth = math.min(screenSize.width, maxWidth);

    return ColoredBox(
      color: const Color(0xFF0A0420),
      child: Center(
        child: SizedBox(
          width: mobileWidth,
          height: screenSize.height,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              size: Size(mobileWidth, screenSize.height),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
