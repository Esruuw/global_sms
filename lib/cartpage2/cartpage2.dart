import 'package:flutter/material.dart';

class MycartApp extends StatelessWidget {
  const MycartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const CartScreen(),
    );
  }
}

// ── Data model ───────────────────────────────────────────────────────────────

class _VideoPackage {
  final int sessions;
  final double price;
  const _VideoPackage({required this.sessions, required this.price});

  String get label =>
      '${sessions} video Session${sessions > 1 ? '' : ''}';
  String get priceLabel => '\$${price.toInt()}';
}

// ── Screen ───────────────────────────────────────────────────────────────────

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<_VideoPackage> _packages = const [
    _VideoPackage(sessions: 5, price: 10),
    _VideoPackage(sessions: 10, price: 20),
    _VideoPackage(sessions: 20, price: 40),
    _VideoPackage(sessions: 40, price: 80),
  ];

  int _selectedIndex = 0; // first item pre-selected (checked)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Galaxy background ──────────────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.4, -0.2),
                radius: 1.4,
                colors: [
                  Color(0xFF8B2FC9),
                  Color(0xFF5A1090),
                  Color(0xFF2A0860),
                  Color(0xFF0D0520),
                ],
                stops: [0.0, 0.3, 0.6, 1.0],
              ),
            ),
          ),
          const _StarField(),

          // ── Content ───────────────────────────────────────────────────
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: const Icon(Icons.chevron_left,
                            color: Colors.white, size: 30),
                      ),
                      const Expanded(
                        child: Text(
                          'CART',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.5,
                          ),
                        ),
                      ),
                      // balance spacer
                      const SizedBox(width: 30),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Section label
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'PURCHASE YOUR VIDEO CHATS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Package list
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    itemCount: _packages.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final pkg = _packages[index];
                      final isSelected = index == _selectedIndex;
                      return _PackageRow(
                        package: pkg,
                        isSelected: isSelected,
                        onTap: () => setState(() => _selectedIndex = index),
                      );
                    },
                  ),
                ),

                // Pay with Google button
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: _GooglePayButton(
                    onTap: () {
                      // handle payment
                    },
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

// ── Package row card ─────────────────────────────────────────────────────────

class _PackageRow extends StatelessWidget {
  final _VideoPackage package;
  final bool isSelected;
  final VoidCallback onTap;

  const _PackageRow({
    required this.package,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFD8D0E8).withOpacity(0.88),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF7B3FF5)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF7B3FF5).withOpacity(0.35),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            // Checkbox
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3A2080)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF3A2080)
                      : Colors.black45,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check,
                      size: 15, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 14),

            // Label
            Expanded(
              child: Text(
                package.label,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Price
            Text(
              package.priceLabel,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Google Pay button ────────────────────────────────────────────────────────

class _GooglePayButton extends StatelessWidget {
  final VoidCallback onTap;
  const _GooglePayButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google "G" logo painted manually
            const _GoogleLogo(size: 26),
            const SizedBox(width: 10),
            const Text(
              'Pay with Google',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Google logo (4-color "G") ────────────────────────────────────────────────

class _GoogleLogo extends StatelessWidget {
  final double size;
  const _GoogleLogo({required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _GoogleLogoPainter(),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width / 2;
    final cx = r;
    final cy = r;

    // Clip to circle
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: Offset(cx, cy), radius: r)));

    // Red top-right arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      -1.57, // -90 deg
      1.57,  // 90 deg
      true,
      Paint()..color = const Color(0xFFEA4335),
    );
    // Blue bottom-right
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      0,
      1.57,
      true,
      Paint()..color = const Color(0xFF4285F4),
    );
    // Green bottom-left
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      1.57,
      1.57,
      true,
      Paint()..color = const Color(0xFF34A853),
    );
    // Yellow top-left
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      3.14,
      1.57,
      true,
      Paint()..color = const Color(0xFFFBBC05),
    );

    // Inner white circle (donut)
    canvas.drawCircle(
      Offset(cx, cy),
      r * 0.60,
      Paint()..color = Colors.white,
    );

    // Blue horizontal bar (the crossbar of the G)
    final barH = r * 0.28;
    canvas.drawRect(
      Rect.fromLTRB(cx, cy - barH / 2, cx + r, cy + barH / 2),
      Paint()..color = const Color(0xFF4285F4),
    );

    // Re-draw inner white circle to clean up bar overflow on left
    canvas.drawCircle(
      Offset(cx, cy),
      r * 0.60,
      Paint()..color = Colors.white,
    );

    // Final blue sector + bar redraw (right half only)
    canvas.drawRect(
      Rect.fromLTRB(cx, cy - barH / 2, cx + r * 0.42, cy + barH / 2),
      Paint()..color = const Color(0xFF4285F4),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Star field ───────────────────────────────────────────────────────────────

class _StarField extends StatelessWidget {
  const _StarField();

  @override
  Widget build(BuildContext context) =>
      CustomPaint(painter: _StarPainter(), child: const SizedBox.expand());
}

class _StarPainter extends CustomPainter {
  static const List<Offset> _pos = [
    Offset(0.05, 0.05), Offset(0.14, 0.19), Offset(0.27, 0.04),
    Offset(0.39, 0.12), Offset(0.53, 0.02), Offset(0.67, 0.16),
    Offset(0.79, 0.06), Offset(0.91, 0.21), Offset(0.97, 0.09),
    Offset(0.08, 0.37), Offset(0.21, 0.50), Offset(0.35, 0.46),
    Offset(0.49, 0.57), Offset(0.62, 0.43), Offset(0.75, 0.55),
    Offset(0.88, 0.48), Offset(0.04, 0.67), Offset(0.16, 0.78),
    Offset(0.32, 0.70), Offset(0.46, 0.83), Offset(0.60, 0.73),
    Offset(0.73, 0.86), Offset(0.85, 0.76), Offset(0.97, 0.90),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < _pos.length; i++) {
      final r = (i % 3 == 0) ? 1.4 : (i % 3 == 1) ? 0.9 : 0.6;
      canvas.drawCircle(
        Offset(_pos[i].dx * size.width, _pos[i].dy * size.height),
        r,
        Paint()..color = Colors.white.withOpacity(0.65),
      );
    }
    final bright = Paint()..color = Colors.white.withOpacity(0.92);
    canvas.drawCircle(Offset(size.width * 0.84, size.height * 0.27), 2.0, bright);
    canvas.drawCircle(Offset(size.width * 0.13, size.height * 0.61), 1.8, bright);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}