import 'package:flutter/material.dart';

class VideoChatScreen extends StatelessWidget {
  const VideoChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const _VideoChatPage(),
    );
  }
}

class _VideoChatPage extends StatelessWidget {
  const _VideoChatPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB0B8C1),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ── Title ──────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '→ VIDEO CHAT ←',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: Color(0xFF3A3A4A),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ── User 2 card ────────────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _VideoCard(
                  userName: 'user2name',
                  avatarColor: const Color(0xFF9FB8D8),
                  bodyColor: const Color(0xFF7A9EC0),
                  bgColor: const Color(0xFFD0DCE8),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // ── User 1 card ────────────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _VideoCard(
                  userName: 'user1name',
                  avatarColor: const Color(0xFFD4A97A),
                  bodyColor: const Color(0xFFC48F5A),
                  bgColor: const Color(0xFFE8D5B8),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ── Single video call card ──────────────────────────────────────────────────

class _VideoCard extends StatefulWidget {
  final String userName;
  final Color avatarColor;
  final Color bodyColor;
  final Color bgColor;

  const _VideoCard({
    required this.userName,
    required this.avatarColor,
    required this.bodyColor,
    required this.bgColor,
  });

  @override
  State<_VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<_VideoCard> {
  bool _micOn = true;
  bool _camOn = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFCDD5DC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFABB5C0), width: 1.5),
      ),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header row ────────────────────────────────────────
          Row(
            children: [
              // PIC thumbnail
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFB8C8D8),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white38),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      size: 20,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    const Text(
                      'PIC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Name + online
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C2C3A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF4CAF50),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Online',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Three-dot menu
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Color(0xFF5A6070),
                  size: 22,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // ── Video area ────────────────────────────────────────
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                color: widget.bgColor,
                child: _AvatarPlaceholder(
                  headColor: widget.avatarColor,
                  bodyColor: widget.bodyColor,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ── Controls row ──────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mic toggle
              _ControlButton(
                icon: _micOn ? Icons.mic_outlined : Icons.mic_off_outlined,
                onTap: () => setState(() => _micOn = !_micOn),
              ),
              const SizedBox(width: 14),
              // Camera toggle
              _ControlButton(
                icon: _camOn
                    ? Icons.videocam_outlined
                    : Icons.videocam_off_outlined,
                onTap: () => setState(() => _camOn = !_camOn),
              ),
              const SizedBox(width: 14),
              // Chat
              _ControlButton(
                icon: Icons.chat_bubble_outline,
                onTap: () {},
              ),
              const SizedBox(width: 14),
              // End call
              _EndCallButton(),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Avatar placeholder ───────────────────────────────────────────────────────

class _AvatarPlaceholder extends StatelessWidget {
  final Color headColor;
  final Color bodyColor;

  const _AvatarPlaceholder({
    required this.headColor,
    required this.bodyColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AvatarPainter(headColor: headColor, bodyColor: bodyColor),
      child: const SizedBox.expand(),
    );
  }
}

class _AvatarPainter extends CustomPainter {
  final Color headColor;
  final Color bodyColor;

  const _AvatarPainter({required this.headColor, required this.bodyColor});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final headRadius = size.width * 0.18;
    final headCy = size.height * 0.34;

    // Head
    canvas.drawCircle(
      Offset(cx, headCy),
      headRadius,
      Paint()..color = headColor,
    );

    // Body (rounded-top trapezoid via path)
    final bodyTop = headCy + headRadius * 0.6;
    final bodyW = size.width * 0.42;
    final bodyH = size.height * 0.38;
    final path = Path()
      ..moveTo(cx - bodyW / 2, size.height)
      ..lineTo(cx - bodyW / 2, bodyTop + bodyH * 0.15)
      ..quadraticBezierTo(
        cx - bodyW / 2,
        bodyTop,
        cx - bodyW * 0.15,
        bodyTop,
      )
      ..quadraticBezierTo(cx, bodyTop - bodyH * 0.05, cx + bodyW * 0.15, bodyTop)
      ..quadraticBezierTo(
        cx + bodyW / 2,
        bodyTop,
        cx + bodyW / 2,
        bodyTop + bodyH * 0.15,
      )
      ..lineTo(cx + bodyW / 2, size.height)
      ..close();

    canvas.drawPath(path, Paint()..color = bodyColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Control button ───────────────────────────────────────────────────────────

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ControlButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.85),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 22, color: const Color(0xFF4A5060)),
      ),
    );
  }
}

// ── End call button ──────────────────────────────────────────────────────────

class _EndCallButton extends StatelessWidget {
  const _EndCallButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.maybePop(context),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFE53935),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE53935).withOpacity(0.35),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.call_end, color: Colors.white, size: 20),
            SizedBox(width: 6),
            Text(
              'End',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}