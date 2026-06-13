import 'package:flutter/material.dart';
import 'package:main/dateandtime/date_time_view.dart';
import 'package:main/videochat/VideoChatScreen.dart';

class Managerpage extends StatelessWidget {
  const Managerpage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MANAGE YOUR RELATIONS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const ManagerScreen(),
    );
  }
}

// ── Screen ───────────────────────────────────────────────────────────────────

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({super.key});

  @override
  State<ManagerScreen> createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  DateTime _focusedMonth = DateTime(2025, 1, 1);
  DateTime? _selectedDay = DateTime(2025, 1, 19);

  final List<_VoiceUser> _users = [
    _VoiceUser(name: 'User name', isOnline: true),
    _VoiceUser(name: 'User name', isOnline: true),
    _VoiceUser(name: 'User name', isOnline: true),
    _VoiceUser(name: 'User name', isOnline: true),
  ];

  void _prevMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 1);
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
                center: Alignment(0.5, 0.1),
                radius: 1.4,
                colors: [
                  Color(0xFF8B2FC9),
                  Color(0xFF4A1080),
                  Color(0xFF1E0840),
                  Color(0xFF0A0420),
                ],
                stops: [0.0, 0.3, 0.65, 1.0],
              ),
            ),
          ),
          const _StarField(),

          SafeArea(
            child: Column(
              children: [
                // ── App bar ──────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      const Text(
                        'MANAGE YOUR RELATIONS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.5,
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

                // ── Scrollable body ──────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Column(
                      children: [
                        // Calendar
                        _CalendarCard(
                          focusedMonth: _focusedMonth,
                          selectedDay: _selectedDay,
                          onPrev: _prevMonth,
                          onNext: _nextMonth,
                          onDaySelected: (d) =>
                              setState(() => _selectedDay = d),
                        ),
                        const SizedBox(height: 12),

                        // Voice notification section
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A0E35).withOpacity(0.82),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white12),
                          ),
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Scheduled Voice Notification',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ..._users.asMap().entries.map((entry) {
                                final i = entry.key;
                                final user = entry.value;
                                return Column(
                                  children: [
                                    _VoiceNotificationRow(user: user),
                                    if (i < _users.length - 1)
                                      const Divider(
                                        color: Colors.white12,
                                        height: 20,
                                      ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
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
  final DateTime focusedMonth;
  final DateTime? selectedDay;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final ValueChanged<DateTime> onDaySelected;

  const _CalendarCard({
    required this.focusedMonth,
    required this.selectedDay,
    required this.onPrev,
    required this.onNext,
    required this.onDaySelected,
  });

  static const _weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  static const _monthNames = [
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

  List<DateTime?> _buildDays() {
    final firstDay = DateTime(focusedMonth.year, focusedMonth.month, 1);
    final daysInMonth = DateTime(
      focusedMonth.year,
      focusedMonth.month + 1,
      0,
    ).day;
    final startWeekday = firstDay.weekday % 7; // Sunday = 0
    final cells = <DateTime?>[];
    for (int i = 0; i < startWeekday; i++) cells.add(null);
    for (int d = 1; d <= daysInMonth; d++) {
      cells.add(DateTime(focusedMonth.year, focusedMonth.month, d));
    }
    return cells;
  }

  bool _isToday(DateTime d) {
    final now = DateTime.now();
    return d.year == now.year && d.month == now.month && d.day == now.day;
  }

  bool _isSelected(DateTime d) {
    return selectedDay != null &&
        d.year == selectedDay!.year &&
        d.month == selectedDay!.month &&
        d.day == selectedDay!.day;
  }

  @override
  Widget build(BuildContext context) {
    final days = _buildDays();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.93),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        children: [
          // Month header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onPrev,
                child: const Icon(
                  Icons.chevron_left,
                  color: Colors.black54,
                  size: 26,
                ),
              ),
              Text(
                _monthNames[focusedMonth.month - 1],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                ),
              ),
              GestureDetector(
                onTap: onNext,
                child: const Icon(
                  Icons.chevron_right,
                  color: Colors.black54,
                  size: 26,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Weekday labels
          Row(
            children: _weekdays
                .map(
                  (w) => Expanded(
                    child: Center(
                      child: Text(
                        w,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 4),

          // Day grid
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 1.1,
            children: days.map((day) {
              if (day == null) return const SizedBox();
              final isSel = _isSelected(day);
              final isTod = _isToday(day);
              final isSunday = day.weekday == 7;

              return GestureDetector(
                onTap: () => onDaySelected(day),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSel ? const Color(0xFF6B2FD9) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSel || isTod
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSel
                            ? Colors.white
                            : isTod
                            ? const Color(0xFFCC2222)
                            : isSunday
                            ? Colors.black45
                            : Colors.black87,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ── Voice notification row ────────────────────────────────────────────────────

class _VoiceUser {
  final String name;
  final bool isOnline;
  _VoiceUser({required this.name, required this.isOnline});
}

class _VoiceNotificationRow extends StatefulWidget {
  final _VoiceUser user;
  const _VoiceNotificationRow({required this.user});

  @override
  State<_VoiceNotificationRow> createState() => _VoiceNotificationRowState();
}

class _VoiceNotificationRowState extends State<_VoiceNotificationRow> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User info row
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white12,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24),
              ),
              child: const Icon(
                Icons.person_outline,
                color: Colors.white70,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.user.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: widget.user.isOnline
                    ? const Color(0xFF2ECC40)
                    : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              widget.user.isOnline ? 'Online' : 'Offline',
              style: TextStyle(
                color: widget.user.isOnline
                    ? const Color(0xFF2ECC40)
                    : Colors.grey,
                fontSize: 11.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Waveform + play button
        Row(
          children: [
            Expanded(child: _WaveformWidget(isPlaying: _isPlaying)),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => setState(() => _isPlaying = !_isPlaying),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white38),
                ),
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Action buttons
        Row(
          children: [
            _ActionButton(icon: Icons.mic, label: 'Record', onTap: () {}),
            const SizedBox(width: 6),
            _ActionButton(
              icon: Icons.videocam_outlined,
              label: 'Video',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const VideoChatScreen()),
                );
              },
            ),
            const SizedBox(width: 6),
            _ActionButton(
              icon: Icons.save_outlined,
              label: 'Save',
              onTap: () {},
            ),
            const SizedBox(width: 6),
            _ActionButton(
              icon: Icons.replay_outlined,
              label: 'Reply',
              onTap: () {},
            ),
            const SizedBox(width: 6),
            _ActionButton(
              icon: Icons.delete_outline,
              label: 'Delete',
              onTap: () {},
              isDestructive: false,
            ),
          ],
        ),
      ],
    );
  }
}

// ── Waveform widget ───────────────────────────────────────────────────────────

class _WaveformWidget extends StatelessWidget {
  final bool isPlaying;
  const _WaveformWidget({required this.isPlaying});

  static const List<double> _heights = [
    0.4,
    0.7,
    0.5,
    0.9,
    0.6,
    0.8,
    0.4,
    0.7,
    0.5,
    1.0,
    0.6,
    0.8,
    0.4,
    0.7,
    0.9,
    0.5,
    0.8,
    0.6,
    0.7,
    0.4,
    0.9,
    0.5,
    0.7,
    0.6,
    0.8,
    0.4,
    0.5,
    0.7,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: CustomPaint(
        painter: _WaveformPainter(heights: _heights, isPlaying: isPlaying),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  final List<double> heights;
  final bool isPlaying;

  _WaveformPainter({required this.heights, required this.isPlaying});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isPlaying ? const Color(0xFF7B3FF5) : Colors.white60
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.5;

    final barWidth = size.width / (heights.length * 2 - 1);
    for (int i = 0; i < heights.length; i++) {
      final x = i * barWidth * 2 + barWidth / 2;
      final barH = heights[i] * size.height;
      final top = (size.height - barH) / 2;
      canvas.drawLine(Offset(x, top), Offset(x, top + barH), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WaveformPainter old) =>
      old.isPlaying != isPlaying;
}

// ── Action button ─────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isDestructive ? const Color(0xFFCF6679) : Colors.white70,
                size: 16,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: isDestructive
                      ? const Color(0xFFCF6679)
                      : Colors.white70,
                  fontSize: 10,
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
  Widget build(BuildContext context) =>
      CustomPaint(painter: _StarPainter(), child: const SizedBox.expand());
}

class _StarPainter extends CustomPainter {
  static const List<Offset> _pos = [
    Offset(0.05, 0.05),
    Offset(0.14, 0.19),
    Offset(0.27, 0.04),
    Offset(0.39, 0.12),
    Offset(0.53, 0.02),
    Offset(0.67, 0.16),
    Offset(0.79, 0.06),
    Offset(0.91, 0.21),
    Offset(0.97, 0.09),
    Offset(0.08, 0.37),
    Offset(0.21, 0.50),
    Offset(0.35, 0.46),
    Offset(0.49, 0.57),
    Offset(0.62, 0.43),
    Offset(0.75, 0.55),
    Offset(0.88, 0.48),
    Offset(0.04, 0.67),
    Offset(0.16, 0.78),
    Offset(0.32, 0.70),
    Offset(0.46, 0.83),
    Offset(0.60, 0.73),
    Offset(0.73, 0.86),
    Offset(0.85, 0.76),
    Offset(0.97, 0.90),
    Offset(0.11, 0.93),
    Offset(0.54, 0.91),
    Offset(0.79, 0.63),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < _pos.length; i++) {
      final r = (i % 3 == 0)
          ? 1.4
          : (i % 3 == 1)
          ? 0.9
          : 0.6;
      canvas.drawCircle(
        Offset(_pos[i].dx * size.width, _pos[i].dy * size.height),
        r,
        Paint()..color = Colors.white.withOpacity(0.65),
      );
    }
    final bright = Paint()..color = Colors.white.withOpacity(0.92);
    canvas.drawCircle(
      Offset(size.width * 0.84, size.height * 0.27),
      2.0,
      bright,
    );
    canvas.drawCircle(
      Offset(size.width * 0.13, size.height * 0.61),
      1.8,
      bright,
    );
    canvas.drawCircle(
      Offset(size.width * 0.52, size.height * 0.40),
      1.5,
      bright,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
