import 'package:flutter/material.dart';





// ── Screen ───────────────────────────────────────────────────────────────────

class SelectDateTimeScreen extends StatefulWidget {
  const SelectDateTimeScreen({super.key});

  @override
  State<SelectDateTimeScreen> createState() => _SelectDateTimeScreenState();
}

class _SelectDateTimeScreenState extends State<SelectDateTimeScreen> {
  DateTime _focusedMonth = DateTime(2025, 1, 1);
  DateTime? _selectedDay = DateTime(2025, 1, 19);
  String? _selectedTime;

  static const List<String> _amTimes = [
    '9:00 AM', '11:00 AM', '1:00 AM', '2:00 AM', '3:00 AM',
    '5:00 AM', '7:00 AM', '8:00 AM', '9:00 AM',
  ];

  static const List<String> _pmTimes = [
    '9:00 PM', '11:00 PM', '1:00 PM', '2:00 PM', '3:00 PM',
    '5:00 PM', '7:00 PM', '8:00 PM', '9:00 PM',
  ];

  void _prevMonth() => setState(() {
        _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1, 1);
      });

  void _nextMonth() => setState(() {
        _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 1);
      });

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
                center: Alignment(0.5, 0.3),
                radius: 1.3,
                colors: [
                  Color(0xFF9B2FD9),
                  Color(0xFF5A1090),
                  Color(0xFF2A0860),
                  Color(0xFF0D0525),
                ],
                stops: [0.0, 0.3, 0.65, 1.0],
              ),
            ),
          ),
          const _StarField(),

          SafeArea(
            child: Column(
              children: [
                // App bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
                      ),
                      const Expanded(
                        child: Text(
                          'SELECT DATE AND TIME',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.8,
                          ),
                        ),
                      ),
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Icon(Icons.person_outline, color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Calendar
                        _CalendarCard(
                          focusedMonth: _focusedMonth,
                          selectedDay: _selectedDay,
                          onPrev: _prevMonth,
                          onNext: _nextMonth,
                          onDaySelected: (d) => setState(() => _selectedDay = d),
                        ),
                        const SizedBox(height: 16),

                        // Select Time label
                        const Text(
                          'Select Time',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Time grid — 2 columns
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: _amTimes.asMap().entries.map((e) {
                                  final key = '${e.value}_am_${e.key}';
                                  return _TimeOption(
                                    time: e.value,
                                    selected: _selectedTime == key,
                                    onTap: () => setState(() => _selectedTime = key),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                children: _pmTimes.asMap().entries.map((e) {
                                  final key = '${e.value}_pm_${e.key}';
                                  return _TimeOption(
                                    time: e.value,
                                    selected: _selectedTime == key,
                                    onTap: () => setState(() => _selectedTime = key),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Confirm Schedule button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6B2FD9),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 8,
                              shadowColor: const Color(0xFF6B2FD9).withOpacity(0.5),
                            ),
                            child: const Text(
                              'CONFIRM SCHEDULE',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
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

// ── Time option ───────────────────────────────────────────────────────────────

class _TimeOption extends StatelessWidget {
  final String time;
  final bool selected;
  final VoidCallback onTap;

  const _TimeOption({required this.time, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? Colors.white : Colors.transparent,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF5A1090),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              time,
              style: TextStyle(
                color: selected ? Colors.white : Colors.white70,
                fontSize: 13,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
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
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  List<DateTime?> _buildDays() {
    final firstDay = DateTime(focusedMonth.year, focusedMonth.month, 1);
    final daysInMonth = DateTime(focusedMonth.year, focusedMonth.month + 1, 0).day;
    final startWeekday = firstDay.weekday % 7;
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

  bool _isSelected(DateTime d) =>
      selectedDay != null &&
      d.year == selectedDay!.year &&
      d.month == selectedDay!.month &&
      d.day == selectedDay!.day;

  @override
  Widget build(BuildContext context) {
    final days = _buildDays();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.93),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          // Month header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onPrev,
                child: const Icon(Icons.chevron_left, color: Colors.black54, size: 24),
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
                child: const Icon(Icons.chevron_right, color: Colors.black54, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Weekday labels
          Row(
            children: _weekdays
                .map((w) => Expanded(
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
                    ))
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
                        fontSize: 12.5,
                        fontWeight: isSel || isTod ? FontWeight.bold : FontWeight.normal,
                        color: isSel
                            ? Colors.white
                            : isTod
                                ? const Color(0xFFCC2222)
                                : isSunday
                                    ? Colors.black38
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

// ── Star field ────────────────────────────────────────────────────────────────

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
    Offset(0.11, 0.93), Offset(0.54, 0.91), Offset(0.79, 0.63),
    Offset(0.22, 0.30), Offset(0.66, 0.66), Offset(0.43, 0.22),
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
    final bright = Paint()..color = Colors.white.withOpacity(0.95);
    canvas.drawCircle(Offset(size.width * 0.82, size.height * 0.26), 2.2, bright);
    canvas.drawCircle(Offset(size.width * 0.12, size.height * 0.60), 1.8, bright);
    canvas.drawCircle(Offset(size.width * 0.50, size.height * 0.38), 1.5, bright);
    canvas.drawCircle(Offset(size.width * 0.30, size.height * 0.75), 1.6, bright);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}