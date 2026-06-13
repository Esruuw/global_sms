import 'package:flutter/material.dart';
import 'package:main/dateandtime/date_time_view.dart';
import 'package:main/videochat/VideoChatScreen.dart';

class ManagerScreen extends StatelessWidget {
  const ManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const _ManagerPage(),
    );
  }
}

class _ManagerPage extends StatefulWidget {
  const _ManagerPage();

  @override
  State<_ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<_ManagerPage> {
  int _currentMonth = 0; // 0 = January
  int _currentYear = 2025;

  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  void _prevMonth() {
    setState(() {
      if (_currentMonth == 0) {
        _currentMonth = 11;
        _currentYear--;
      } else {
        _currentMonth--;
      }
    });
  }

  void _nextMonth() {
    setState(() {
      if (_currentMonth == 11) {
        _currentMonth = 0;
        _currentYear++;
      } else {
        _currentMonth++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          // Star field
          const _StarField(),

          SafeArea(
            child: Column(
              children: [
                // ── Top bar ──────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
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
                            'MANAGE YOUR RELATIONS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SelectDateTimeScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: const Icon(
                            Icons.person_outline,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Scrollable content ────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        // Calendar card
                        _CalendarCard(
                          month: _currentMonth,
                          year: _currentYear,
                          onPrev: _prevMonth,
                          onNext: _nextMonth,
                        ),
                        const SizedBox(height: 16),

                        // Section title
                        const Text(
                          'Scheduled Voice Notification',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Notification groups
                        _NotificationGroup(showActions: true),
                        const SizedBox(height: 12),
                        _NotificationGroup(showActions: true),
                        const SizedBox(height: 12),
                        _NotificationGroup(showActions: false),
                        const SizedBox(height: 20),
                      ],
                    ),
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

// ── Calendar card ─────────────────────────────────────────────────────────────

class _CalendarCard extends StatelessWidget {
  final int month;
  final int year;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  const _CalendarCard({
    required this.month,
    required this.year,
    required this.onPrev,
    required this.onNext,
  });

  int _daysInMonth(int m, int y) {
    return DateTime(y, m + 2, 0).day;
  }

  int _firstWeekday(int m, int y) {
    // 0=Sun,1=Mon,...,6=Sat
    final d = DateTime(y, m + 1, 1).weekday; // Mon=1..Sun=7
    return d % 7; // Sun=0
  }

  @override
  Widget build(BuildContext context) {
    final days = _daysInMonth(month, year);
    final startDay = _firstWeekday(month, year);
    const headers = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    // Build day cells
    final cells = <Widget>[];
    for (int i = 0; i < startDay; i++) {
      cells.add(const SizedBox());
    }
    for (int d = 1; d <= days; d++) {
      final isRed = d == 19;
      cells.add(
        Center(
          child: Text(
            '$d',
            style: TextStyle(
              color: isRed ? const Color(0xFFFF4444) : const Color(0xFF2C2C3A),
              fontSize: 13,
              fontWeight: isRed ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        children: [
          // Month nav row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onPrev,
                child: const Icon(
                  Icons.chevron_left,
                  color: Color(0xFF4A4A5A),
                  size: 24,
                ),
              ),
              Text(
                _monthNames[month],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C2C3A),
                  fontStyle: FontStyle.italic,
                ),
              ),
              GestureDetector(
                onTap: onNext,
                child: const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF4A4A5A),
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Day-of-week headers
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.4,
            children: headers
                .map(
                  (h) => Center(
                    child: Text(
                      h,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6A6A7A),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),

          // Day cells
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.4,
            children: cells,
          ),
        ],
      ),
    );
  }
}

// ── Notification group (two users + optional action buttons) ─────────────────

class _NotificationGroup extends StatelessWidget {
  final bool showActions;

  const _NotificationGroup({required this.showActions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A0E35).withOpacity(0.75),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        children: [
          // User 1 row (online)
          _UserVoiceRow(name: 'User name', isOnline: true),
          const SizedBox(height: 10),

          // User 2 row (offline)
          _UserVoiceRow(name: 'User name 2', isOnline: false),

          if (showActions) ...[const SizedBox(height: 12), _ActionButtons()],
        ],
      ),
    );
  }
}

// ── Single user voice row ────────────────────────────────────────────────────

class _UserVoiceRow extends StatelessWidget {
  final String name;
  final bool isOnline;

  const _UserVoiceRow({required this.name, required this.isOnline});

  static const List<double> _bars = [
    0.4,
    0.7,
    1.0,
    0.6,
    0.85,
    0.5,
    0.9,
    0.65,
    0.75,
    0.45,
    0.8,
    0.55,
    0.95,
    0.7,
    0.5,
    0.85,
    0.6,
    0.4,
    0.75,
    0.9,
    0.55,
    0.7,
    0.45,
    0.8,
    0.6,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name + status
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white10,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24),
              ),
              child: const Icon(Icons.person, color: Colors.white60, size: 18),
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isOnline
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFFE53935),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              isOnline ? 'Online' : 'offline',
              style: TextStyle(
                fontSize: 11,
                color: isOnline
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFFE53935),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Waveform + play button
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 28,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _bars.map((h) {
                    return Container(
                      width: 3,
                      height: (h * 24).clamp(3.0, 24.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white10,
                border: Border.all(color: Colors.white24),
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 17,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Action buttons row ────────────────────────────────────────────────────────

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionBtn(icon: Icons.mic_outlined, label: 'Record', onTap: () {}),
        const SizedBox(width: 6),
        _ActionBtn(
          icon: Icons.videocam_outlined,
          label: 'Video',
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const VideoCallWaitingScreen()));
          },
        ),
        const SizedBox(width: 6),
        _ActionBtn(icon: Icons.reply_outlined, label: 'Reply', onTap: () {}),
        const SizedBox(width: 6),
        _ActionBtn(icon: Icons.save_outlined, label: 'Save', onTap: () {}),
        const SizedBox(width: 6),
        _ActionBtn(icon: Icons.delete_outline, label: 'Delete', onTap: () {}),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 34,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white70, size: 13),
              const SizedBox(width: 3),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Star field ────────────────────────────────────────────────────────────────

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
    Offset(0.10, 0.92),
    Offset(0.30, 0.95),
    Offset(0.52, 0.88),
    Offset(0.70, 0.93),
    Offset(0.90, 0.85),
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
    final bright = Paint()..color = Colors.white.withOpacity(0.9);
    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.15),
      2.0,
      bright,
    );
    canvas.drawCircle(
      Offset(size.width * 0.12, size.height * 0.42),
      1.8,
      bright,
    );
    canvas.drawCircle(
      Offset(size.width * 0.55, size.height * 0.30),
      1.5,
      bright,
    );
    canvas.drawCircle(
      Offset(size.width * 0.92, size.height * 0.65),
      1.6,
      bright,
    );
    canvas.drawCircle(
      Offset(size.width * 0.08, size.height * 0.78),
      1.4,
      bright,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
