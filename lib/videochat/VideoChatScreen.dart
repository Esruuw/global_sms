import 'dart:async';
import 'package:flutter/material.dart';

class VideoCallWaitingScreen extends StatelessWidget {
  const VideoCallWaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const _VideoCallPage(),
    );
  }
}

class _VideoCallPage extends StatefulWidget {
  const _VideoCallPage();

  @override
  State<_VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<_VideoCallPage> {
  late Timer _timer;
  int _secondsLeft = 4 * 60 + 58; // 04:58

  bool _micOn = true;
  bool _camOn = true;
  bool _speakerOn = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _timeString {
    final m = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0520),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Galaxy background
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.4, -0.3),
                radius: 1.3,
                colors: [
                  Color(0xFF7B2FBE),
                  Color(0xFF4A1080),
                  Color(0xFF1E0A40),
                  Color(0xFF0A0520),
                ],
                stops: [0.0, 0.3, 0.6, 1.0],
              ),
            ),
          ),
          const _StarField(),

          SafeArea(
            child: Column(
              children: [
                // ── Top bar ────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                         GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            '%TUNGUY,\u2083Love123',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Icon(Icons.person_outline,
                            color: Colors.white, size: 20),
                      ),
                    ],
                  ),
                ),

                // ── Remote video (top) ─────────────────────────
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: _RemoteVideoPlaceholder(),
                    ),
                  ),
                ),

                // ── Timer + waiting text ───────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Column(
                    children: [
                      // "Call starts in:" label with side lines
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _GlowLine(),
                          const SizedBox(width: 10),
                          const Text(
                            'Call starts in:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(width: 10),
                          _GlowLine(),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Countdown
                      Text(
                        _timeString,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Waiting message
                      const Text(
                        'Waiting for %Love123 to join.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Local video (bottom) ───────────────────────
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: _LocalVideoPlaceholder(),
                    ),
                  ),
                ),

                // ── Control buttons ────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _RoundControlBtn(
                        icon: _micOn
                            ? Icons.mic_outlined
                            : Icons.mic_off_outlined,
                        onTap: () => setState(() => _micOn = !_micOn),
                      ),
                      _RoundControlBtn(
                        icon: _camOn
                            ? Icons.videocam_outlined
                            : Icons.videocam_off_outlined,
                        onTap: () => setState(() => _camOn = !_camOn),
                      ),
                      _RoundControlBtn(
                        icon: _speakerOn
                            ? Icons.volume_up_outlined
                            : Icons.volume_off_outlined,
                        onTap: () =>
                            setState(() => _speakerOn = !_speakerOn),
                      ),
                      // End call — red
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFE53935),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFE53935)
                                    .withOpacity(0.4),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.close,
                              color: Colors.white, size: 26),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Glowing horizontal line beside timer label ────────────────────────────────

class _GlowLine extends StatelessWidget {
  const _GlowLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 2,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.transparent, Color(0xFF7B3FF5)],
        ),
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B3FF5).withOpacity(0.6),
            blurRadius: 6,
          ),
        ],
      ),
    );
  }
}

// ── Remote video placeholder (woman waving) ───────────────────────────────────

class _RemoteVideoPlaceholder extends StatelessWidget {
  const _RemoteVideoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF2A1A3A),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Simulated video: gradient skin-tone background + person silhouette
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6A4A7A), Color(0xFF3A2050)],
              ),
            ),
          ),
          // Person silhouette
          CustomPaint(painter: _PersonSilhouette(isRemote: true)),
          // "Camera" label hint
          const Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '%Love123',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Local video placeholder (man) ────────────────────────────────────────────

class _LocalVideoPlaceholder extends StatelessWidget {
  const _LocalVideoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF1A2030),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF4A5060), Color(0xFF1A2030)],
              ),
            ),
          ),
          CustomPaint(painter: _PersonSilhouette(isRemote: false)),
          const Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'You',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Person silhouette painter ────────────────────────────────────────────────

class _PersonSilhouette extends CustomPainter {
  final bool isRemote;
  const _PersonSilhouette({required this.isRemote});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final headR = size.width * 0.13;
    final headCy = size.height * 0.35;
    final headColor = isRemote
        ? const Color(0xFFD4956A).withOpacity(0.7)
        : const Color(0xFFA07850).withOpacity(0.7);
    final bodyColor = isRemote
        ? const Color(0xFF8A6090).withOpacity(0.5)
        : const Color(0xFF506080).withOpacity(0.5);

    // Head
    canvas.drawCircle(Offset(cx, headCy), headR, Paint()..color = headColor);

    // Body
    final bodyW = size.width * 0.55;
    final bodyTop = headCy + headR * 0.7;
    final path = Path()
      ..moveTo(cx - bodyW / 2, size.height + 10)
      ..lineTo(cx - bodyW / 2, bodyTop + bodyW * 0.15)
      ..quadraticBezierTo(cx - bodyW / 2, bodyTop, cx - bodyW * 0.12, bodyTop)
      ..quadraticBezierTo(cx, bodyTop - 8, cx + bodyW * 0.12, bodyTop)
      ..quadraticBezierTo(cx + bodyW / 2, bodyTop, cx + bodyW / 2, bodyTop + bodyW * 0.15)
      ..lineTo(cx + bodyW / 2, size.height + 10)
      ..close();
    canvas.drawPath(path, Paint()..color = bodyColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ── Round control button ─────────────────────────────────────────────────────

class _RoundControlBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundControlBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.15),
          border: Border.all(color: Colors.white24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}

// ── Star field ───────────────────────────────────────────────────────────────

class _StarField extends StatelessWidget {
  const _StarField();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: _StarPainter(), child: const SizedBox.expand());
  }
}

class _StarPainter extends CustomPainter {
  static const List<Offset> _positions = [
    Offset(0.05, 0.06), Offset(0.15, 0.20), Offset(0.28, 0.04),
    Offset(0.40, 0.13), Offset(0.55, 0.02), Offset(0.68, 0.17),
    Offset(0.80, 0.06), Offset(0.92, 0.22), Offset(0.96, 0.10),
    Offset(0.07, 0.38), Offset(0.22, 0.52), Offset(0.36, 0.47),
    Offset(0.50, 0.58), Offset(0.63, 0.44), Offset(0.76, 0.56),
    Offset(0.89, 0.49), Offset(0.04, 0.68), Offset(0.17, 0.79),
    Offset(0.33, 0.71), Offset(0.47, 0.84), Offset(0.61, 0.74),
    Offset(0.74, 0.87), Offset(0.86, 0.77), Offset(0.98, 0.91),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < _positions.length; i++) {
      final p = _positions[i];
      final r = (i % 3 == 0) ? 1.4 : (i % 3 == 1) ? 1.0 : 0.6;
      canvas.drawCircle(
        Offset(p.dx * size.width, p.dy * size.height),
        r,
        Paint()..color = Colors.white.withOpacity(0.65),
      );
    }
    final bright = Paint()..color = Colors.white.withOpacity(0.9);
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.28), 2.0, bright);
    canvas.drawCircle(Offset(size.width * 0.12, size.height * 0.62), 1.8, bright);
    canvas.drawCircle(Offset(size.width * 0.55, size.height * 0.42), 1.5, bright);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}