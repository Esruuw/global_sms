import 'package:flutter/material.dart';
import 'package:main/Carts/cartpage.dart';
import 'package:main/cartpage2/cartpage2.dart' hide CartScreen;
import 'package:main/savedpage/savedpage.dart';
import 'package:main/search/searchscreen.dart';

class postview extends StatelessWidget {
  const postview({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Black Lamp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BlackLampScreen(),
    );
  }
}

class BlackLampScreen extends StatefulWidget {
  const BlackLampScreen({super.key});

  @override
  State<BlackLampScreen> createState() => _BlackLampScreenState();
}

class _BlackLampScreenState extends State<BlackLampScreen> {
  bool _replyPost = false;
  bool _scheduleVideoMeet = false;
  bool _offerToPayVideoSession = false;
  bool _sendAVmail = false;
  bool _isExpanded = false;

  final String _fullText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua et dolore magna aliqua et dolore magna.';

  final String _shortText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua et dolore magna...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Galaxy background gradient
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
          // Star field
          const _StarField(),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),

                // Main card
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A0E35).withOpacity(0.88),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white12),
                      ),
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Title
                          const Text(
                            'BLACK LAMP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Description
                          GestureDetector(
                            onTap: () =>
                                setState(() => _isExpanded = !_isExpanded),
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.5,
                                  height: 1.55,
                                ),
                                children: [
                                  TextSpan(
                                    text: _isExpanded ? _fullText : _shortText,
                                  ),
                                  if (!_isExpanded)
                                    const TextSpan(
                                      text: 'See More',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Profile image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.grey.shade800,
                              child: const _ProfileImagePlaceholder(),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Price
                          const Text(
                            '\$2PV',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Options grid
                          Row(
                            children: [
                              Expanded(
                                child: _OptionCheckbox(
                                  label: 'REPLY TO POST',
                                  value: _replyPost,
                                  onChanged: (val) =>
                                      setState(() => _replyPost = val),
                                ),
                              ),
                              Expanded(
                                child: _OptionCheckbox(
                                  label: 'SCHEDULE A 2\$ VIDEO SESSION',
                                  value: _scheduleVideoMeet,
                                  onChanged: (val) =>
                                      setState(() => _scheduleVideoMeet = val),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _OptionCheckbox(
                                  label:
                                      'OFFER TO PAY FOR THEIR VIDEO SESSION FOR THEM',
                                  value: _offerToPayVideoSession,
                                  onChanged: (val) => setState(
                                    () => _offerToPayVideoSession = val,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: _OptionCheckbox(
                                  label: 'SEND A FREE VOICE MESSAGE',
                                  value: _sendAVmail,
                                  onChanged: (val) =>
                                      setState(() => _sendAVmail = val),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),

                          // Start button
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const CartScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF7B3FF5),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 6,
                                shadowColor: const Color(
                                  0xFF7B3FF5,
                                ).withOpacity(0.5),
                              ),
                              child: const Text(
                                'Start',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Checkbox option row ──────────────────────────────────────────────────────

class _OptionCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _OptionCheckbox({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom radio-style circle
          Container(
            width: 18,
            height: 18,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? const Color(0xFF7B3FF5) : Colors.transparent,
              border: Border.all(
                color: value ? const Color(0xFF7B3FF5) : Colors.white54,
                width: 2,
              ),
            ),
            child: value
                ? const Icon(Icons.check, size: 11, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Profile image placeholder (grayscale person silhouette) ─────────────────

class _ProfileImagePlaceholder extends StatelessWidget {
  const _ProfileImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(color: const Color(0xFF2A2A2A)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF444444),
              ),
              child: const Icon(
                Icons.person,
                size: 46,
                color: Color(0xFF888888),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 110,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFF444444),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(55),
                  topRight: Radius.circular(55),
                ),
              ),
            ),
          ],
        ),
        // Grayscale overlay hint text
        const Positioned(
          bottom: 8,
          child: Text(
            'Profile Photo',
            style: TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ),
      ],
    );
  }
}

// ── Star field ───────────────────────────────────────────────────────────────

class _StarField extends StatelessWidget {
  const _StarField();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _StarPainter(), child: const SizedBox.expand());
  }
}

class _StarPainter extends CustomPainter {
  static const List<Offset> _positions = [
    Offset(0.05, 0.06),
    Offset(0.15, 0.20),
    Offset(0.28, 0.04),
    Offset(0.40, 0.13),
    Offset(0.55, 0.02),
    Offset(0.68, 0.17),
    Offset(0.80, 0.06),
    Offset(0.92, 0.22),
    Offset(0.96, 0.10),
    Offset(0.07, 0.38),
    Offset(0.22, 0.52),
    Offset(0.36, 0.47),
    Offset(0.50, 0.58),
    Offset(0.63, 0.44),
    Offset(0.76, 0.56),
    Offset(0.89, 0.49),
    Offset(0.04, 0.68),
    Offset(0.17, 0.79),
    Offset(0.33, 0.71),
    Offset(0.47, 0.84),
    Offset(0.61, 0.74),
    Offset(0.74, 0.87),
    Offset(0.86, 0.77),
    Offset(0.98, 0.91),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < _positions.length; i++) {
      final p = _positions[i];
      final r = (i % 3 == 0)
          ? 1.4
          : (i % 3 == 1)
          ? 1.0
          : 0.6;
      canvas.drawCircle(
        Offset(p.dx * size.width, p.dy * size.height),
        r,
        Paint()..color = Colors.white.withOpacity(0.65),
      );
    }
    // A few bright accent stars
    final bright = Paint()..color = Colors.white.withOpacity(0.9);
    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.28),
      2.0,
      bright,
    );
    canvas.drawCircle(
      Offset(size.width * 0.12, size.height * 0.62),
      1.8,
      bright,
    );
    canvas.drawCircle(
      Offset(size.width * 0.55, size.height * 0.42),
      1.5,
      bright,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
