import 'package:flutter/material.dart';
import 'package:main/nations/SearchNationsPage.dart';
import 'package:main/search/searchscreen.dart';



// ── Screen ───────────────────────────────────────────────────────────────────

class GlobalVMailsScreen extends StatefulWidget {
  const GlobalVMailsScreen({super.key});

  @override
  State<GlobalVMailsScreen> createState() => _GlobalVMailsScreenState();
}

class _GlobalVMailsScreenState extends State<GlobalVMailsScreen> {
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _dobController = TextEditingController();
  final _pinController = TextEditingController();
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());

  bool _agreePrivacy = false;
  bool _agreeRules = false;
  bool _agreeLanguage = false;
  bool _agreeAge = false;

  static const List<String> _rules = [
    'You must send a free voice message first to introduce yourself',
    'This is a longterm private / personal video meeting relations application for letter and posting only',
    'You have to show respect to the opposite user',
    'All relations are goals to achieve a goal',
    'You must video chat or voice message to come to equal agreements for the proposed letter post interested in respect of others privacy',
    'You have the freedom to post as you feel but agree to use respectful typing and no full nudity',
    'You agree to use the voice to video meet technology for interviewing and meeting for the interested letter or post, whether long distance or near',
    

  ];

  static const List<String> _agreements = [
    'I agree with the privacy clause of each user having their own privacy freedom',
    'I agree to abide by the rules of the forum for use',
    'I agree to use respectful typing & respectful language',
    'I agree to terms of use',
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    _usernameController.dispose();
    _dobController.dispose();
    _pinController.dispose();
    for (final c in _otpControllers) {
      c.dispose();
    }
    super.dispose();
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
                center: Alignment(0.4, 0.1),
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
          ),
          const _StarField(),

          SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Back button ─────────────────────────────────────────
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: const Icon(Icons.chevron_left,
                          color: Colors.white, size: 28),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ── Logo ────────────────────────────────────────────────
                  const _GlobeLogo(),
                  const SizedBox(height: 10),

                  // ── Headline ─────────────────────────────────────────────
                  const Text(
                    'YOU HAVE FREEDOM TO POST\nA PRIVATE VIDEO CHAT GLOBALLY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ── Sub-headline ─────────────────────────────────────────
                  const Text(
                    'PLEASE SAVE TO PHONE HOME SCREEN AND\nALWAYS RE-CHECK YOUR ACCOUNT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11.5,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // ── Profile video preview card ───────────────────────────
                  _VideoPreviewCard(),
                  const SizedBox(height: 14),

                  // ── Voice message row ────────────────────────────────────
                  _VoiceMessageRow(),
                  const SizedBox(height: 14),

                  // ── Rules to Forum ───────────────────────────────────────
                  _RulesToForumCard(rules: _rules),
                  const SizedBox(height: 14),

                  // ── Agreement checkboxes ─────────────────────────────────
                  _AgreementSection(
                    agreements: _agreements,
                    values: [_agreePrivacy, _agreeRules, _agreeLanguage, _agreeAge],
                    onChanged: (index, val) {
                      setState(() {
                        switch (index) {
                          case 0: _agreePrivacy = val; break;
                          case 1: _agreeRules = val; break;
                          case 2: _agreeLanguage = val; break;
                          case 3: _agreeAge = val; break;
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 14),

                  // ── CREATE / SAVE ACCOUNT ────────────────────────────────
                  _SectionDividerLabel(label: 'CREATE /SAVE YOUR ACCOUNT'),
                  const SizedBox(height: 12),

                  _FormField(
                    controller: _phoneController,
                    hint: 'Phone number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  _FormField(
                    controller: _usernameController,
                    hint: 'User name- User number',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 10),
                  _FormField(
                    controller: _dobController,
                    hint: 'Date of Birth',
                    icon: Icons.calendar_today_outlined,
                    keyboardType: TextInputType.datetime,
                  ),
                  const SizedBox(height: 10),
                  _FormField(
                    controller: _pinController,
                    hint: 'Enter of PIN',
                    icon: Icons.lock_outline,
                    obscure: true,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 14),

                  // ── SEND OTP button ──────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7B3FF5),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 8,
                        shadowColor:
                            const Color(0xFF7B3FF5).withOpacity(0.5),
                      ),
                      child: const Text(
                        'SEND OTP',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // ── OTP boxes ────────────────────────────────────────────
                  _OtpRow(controllers: _otpControllers),
                  const SizedBox(height: 14),

                  // ── I AGREE & SAVE ACCOUNT ───────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SearchScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B2FD9),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 8,
                        shadowColor:
                            const Color(0xFF6B2FD9).withOpacity(0.5),
                      ),
                      child: const Text(
                        'I AGREE & SAVE ACCOUNT',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Footer note
                  const Text(
                    'Pressing this will save your account information.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Globe logo ────────────────────────────────────────────────────────────────

class _GlobeLogo extends StatelessWidget {
  const _GlobeLogo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF0D47A1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.white38, width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2196F3).withOpacity(0.4),
                blurRadius: 14,
                spreadRadius: 2,
              )
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.language, color: Colors.white, size: 42),
              Positioned(
                bottom: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '?',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'GLOBAL\nZZ....VMAILS',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

// ── Video preview card ────────────────────────────────────────────────────────

class _VideoPreviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Placeholder person silhouette
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF555555),
                ),
                child: const Icon(Icons.person,
                    color: Color(0xFF888888), size: 38),
              ),
              const SizedBox(height: 4),
              Container(
                width: 90,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF555555),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
              ),
            ],
          ),
          // Play button overlay
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black45,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white54),
            ),
            child: const Icon(Icons.play_arrow,
                color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }
}

// ── Voice message row ─────────────────────────────────────────────────────────

class _VoiceMessageRow extends StatefulWidget {
  @override
  State<_VoiceMessageRow> createState() => _VoiceMessageRowState();
}

class _VoiceMessageRowState extends State<_VoiceMessageRow> {
  bool _isPlaying = false;

  static const List<double> _waveHeights = [
    0.4, 0.7, 0.5, 0.9, 0.6, 0.8, 0.4, 0.7, 0.5, 1.0,
    0.6, 0.8, 0.4, 0.7, 0.9, 0.5, 0.8, 0.6, 0.7, 0.4,
    0.9, 0.5, 0.7, 0.6, 0.8, 0.4, 0.5, 0.7,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0E35).withOpacity(0.80),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.mic, color: Colors.white70, size: 18),
              const SizedBox(width: 8),
              const Text(
                'Wel Come Voice Message',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: () =>
                    setState(() => _isPlaying = !_isPlaying),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white38),
                  ),
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 26,
                  child: CustomPaint(
                    painter: _WaveformPainter(
                      heights: _waveHeights,
                      isPlaying: _isPlaying,
                    ),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
            ],
          ),
        ],
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
      ..strokeWidth = 2.2;

    final barW = size.width / (heights.length * 2 - 1);
    for (int i = 0; i < heights.length; i++) {
      final x = i * barW * 2 + barW / 2;
      final h = heights[i] * size.height;
      final top = (size.height - h) / 2;
      canvas.drawLine(Offset(x, top), Offset(x, top + h), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WaveformPainter old) =>
      old.isPlaying != isPlaying;
}

// ── Rules to Forum card ───────────────────────────────────────────────────────

class _RulesToForumCard extends StatelessWidget {
  final List<String> rules;
  const _RulesToForumCard({required this.rules});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.90),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rules To Forum',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...rules.asMap().entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${e.key + 1}. ',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          e.value,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 12.5,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

// ── Agreement section ─────────────────────────────────────────────────────────

class _AgreementSection extends StatelessWidget {
  final List<String> agreements;
  final List<bool> values;
  final void Function(int index, bool val) onChanged;

  const _AgreementSection({
    required this.agreements,
    required this.values,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: agreements.asMap().entries.map((e) {
        final i = e.key;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GestureDetector(
            onTap: () => onChanged(i, !values[i]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  width: 18,
                  height: 18,
                  margin: const EdgeInsets.only(top: 1),
                  decoration: BoxDecoration(
                    color: values[i]
                        ? const Color(0xFF7B3FF5)
                        : Colors.white24,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: values[i]
                          ? const Color(0xFF7B3FF5)
                          : Colors.white54,
                      width: 1.5,
                    ),
                  ),
                  child: values[i]
                      ? const Icon(Icons.check,
                          color: Colors.white, size: 12)
                      : null,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    e.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ── Section divider label ─────────────────────────────────────────────────────

class _SectionDividerLabel extends StatelessWidget {
  final String label;
  const _SectionDividerLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.white30, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.white30, thickness: 1)),
      ],
    );
  }
}

// ── Form field ────────────────────────────────────────────────────────────────

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextInputType keyboardType;

  const _FormField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD8D0E8).withOpacity(0.85),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.black87, fontSize: 13.5),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
              const TextStyle(color: Colors.black45, fontSize: 13.5),
          prefixIcon: Icon(icon, color: Colors.black54, size: 20),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
      ),
    );
  }
}

// ── OTP row ───────────────────────────────────────────────────────────────────

class _OtpRow extends StatelessWidget {
  final List<TextEditingController> controllers;
  const _OtpRow({required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (i) {
        return SizedBox(
          width: 44,
          height: 48,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD8D0E8).withOpacity(0.85),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controllers[i],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (val) {
                if (val.isNotEmpty && i < 5) {
                  FocusScope.of(context).nextFocus();
                } else if (val.isEmpty && i > 0) {
                  FocusScope.of(context).previousFocus();
                }
              },
            ),
          ),
        );
      }),
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
    Offset(0.05, 0.05), Offset(0.14, 0.12), Offset(0.27, 0.04),
    Offset(0.39, 0.09), Offset(0.53, 0.02), Offset(0.67, 0.11),
    Offset(0.79, 0.06), Offset(0.91, 0.15), Offset(0.97, 0.07),
    Offset(0.08, 0.25), Offset(0.21, 0.35), Offset(0.35, 0.30),
    Offset(0.49, 0.40), Offset(0.62, 0.28), Offset(0.75, 0.38),
    Offset(0.88, 0.33), Offset(0.04, 0.50), Offset(0.16, 0.58),
    Offset(0.32, 0.52), Offset(0.46, 0.62), Offset(0.60, 0.55),
    Offset(0.73, 0.65), Offset(0.85, 0.57), Offset(0.97, 0.70),
    Offset(0.11, 0.75), Offset(0.54, 0.72), Offset(0.79, 0.80),
    Offset(0.22, 0.88), Offset(0.66, 0.90), Offset(0.43, 0.95),
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
    canvas.drawCircle(
        Offset(size.width * 0.83, size.height * 0.18), 2.0, bright);
    canvas.drawCircle(
        Offset(size.width * 0.12, size.height * 0.45), 1.8, bright);
    canvas.drawCircle(
        Offset(size.width * 0.50, size.height * 0.25), 1.5, bright);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}