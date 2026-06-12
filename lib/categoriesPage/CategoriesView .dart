import 'package:flutter/material.dart';
import 'package:main/nations/SearchNationsPage.dart';

// ── Screen ───────────────────────────────────────────────────────────────────

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  static const List<_CategorySection> _allSections = [
    _CategorySection(
      title: 'REGULAR CATEGORIES - REASONS:',
      items: [
        'FOR VIDEO MEET - PERSONAL / PRIVATE BUSINESS CAUSES',
        'FOR VIDEO MEET - VIDEO INTRODUCTIONS',
        'FOR VIDEO MEET - VIDEO TEACHINGS SESSIONS',
        'FOR VIDEO MEET - NEW PRIVATE STARTUPS 4 FAIR BUSINESS',
        'FOR VIDEO MEET - PRIVATE GOOD CAUSES',
        'FOR VIDEO MEET - P2P LOCAL NEEDS',
        'FOR VIDEO MEET - FAR AWAY TO EVENTUALLY TRAVEL',
      ],
    ),
    _CategorySection(
      title: 'PERSONALS VIDEO CATEGORIES - REASONS:',
      items: [
        'PROFESSIONAL VIDEO MEETING',
        'LONGTERM DISTANCED ANYTHING',
        'BUILDING SOLID RELATIONS FOR?',
        'SMALL BUSINESS P2P / B2B',
        'REFER ME TO A JOB',
        'UPCOMING EVENTS',
        'MUSIC STUFF CATEGORY',
        'MEETING SAFE ONLY TRAVELERS',
        'TRUSTFUL TAG TEAMING PARTNERS',
        'COMPUTER HELP',
        'NEEDS HELP WITH',
        'WOULD LIKE TO MEET FOR NEEDS',
        'RANDOM STUFF - LEAVE ME A V-MESSAGE',
        'POST LETTERS GLOBAL LETTERS',
        'FROM ACROSS THE MAP - LINK UP FOR LEGAL BUSINESS',
        'MAKING MONEY GOAL - TAG TEAM',
        'PERSONAL HIRING - PER NEEDS',
        'POSITIVE GROUP TYPES CAUSES',
        'HELPING OTHERS FOR FREE',
        'FREE STUFF',
        'COLLEGE / AFTER GRAD',
        'A STUDY PARTNER NEEDS HELP',
        'RENT PARTNERS',
        'REGULAR PUBLIC ACTIVITIES FOR?',
        'CREATIVE FRIENDS?',
        'PRODUCTIVE STUFF',
        'CREATIVE PROJECTS TOGETHER',
        'FOR A POSITIVE FUTURE HUSTLE UP GOAL TAG TEAM',
        'BUSINESS PARTNERS… LOOKING FOR',
        'NEED SMALL INVESTORS FOR?',
      ],
    ),
    _CategorySection(
      title: 'VIDEO DATING CATEGORIES - REASONS:',
      items: [
        'DATING LETTERS - LOOKING FOR',
        'GLOBAL DATING FROM & TO - LOOKING FOR',
        'ANY BODY INTERESTED IN?',
        'WANTING KIND OF SIMILAR LIFESTYLES?',
        'PRIVATE / PERSONAL CONVO?',
        'GYM DATING?',
        'JOGGING OR WALKING TOGETHER?',
        'GOING OUT TO EAT FRIENDS?',
        'VOICE MESSAGE PEN PAL?',
        '21 - 40 YOUNGER DATING ONLY',
        '45 -69+ OLDER DATING ONLY',
        'POSITIVE NEEDS ONLY',
        'STRAIGHT & REGULAR NORMAL COMMUNITY',
        'MATURED ESTABLISHED DATING',
        'LGBTQIA COMMUNITY',
        'PRIVATE POSSIBLE FUTURE FRIENDS',
        'VOICE SEXY MESSAGE FOR FUN CONVO',
        'REG. SELFIE MODEL S / AFTER MODELING DATERS',
        'EQUAL / HIGH QUALITY PEOPLE DATING',
        'LONG DISTANCE DATERS',
        'LOOKING FOR OLDER THAN ME STYLE',
        'LOOKING FOR SLIGHTLY YOUNGER THAN ME STYLE',
        'SUGAR PARTNER DATING - NEEDS',
        'PRODUCTIVE ONLY DATING',
        'TEACHING EACH OTHER STUFF DATING',
        'PLATONIC ONLY ANYONE?',
        'RELIGOUS STYLE BACKGROUND DATING',
        'LOOKING FOR A NEW FRIEND ONLY',
        'MEETING FOR THE LONGTERM?',
        'POORER PEOPLE LEVEL DATING 50/50 SOLUTIONS',
        'LOOKING FOR LOCAL ONLY',
        'FOR RENT MATES DATING',
        'HEALTHY FOR - ONLY IF WE EVER DID…',
        'EXACTLY LIKE ME - FOR MY PRIVATE LEVEL - VOICE CONVO',
        'FUTURE FRIEND / MATE',
        'SUPER HOT SEXY DATERS',
        'BOTH ON EQUAL LEVELS',
        'RICHER PEOPLE DATING',
        'REGULAR LEVEL DATING',
      ],
    ),
  ];

  List<_CategoryListEntry> get _filteredEntries {
    final lowerQuery = _query.toLowerCase();
    final entries = <_CategoryListEntry>[];

    for (final section in _allSections) {
      final visibleItems = _query.isEmpty
          ? section.items
          : section.items
                .where((item) => item.toLowerCase().contains(lowerQuery))
                .toList();

      if (visibleItems.isEmpty) {
        continue;
      }

      entries.add(_CategoryListEntry(section.title, isSectionTitle: true));
      entries.addAll(visibleItems.map((item) => _CategoryListEntry(item)));
    }

    return entries;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                center: Alignment(0.5, 0.2),
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

          // ── Content ────────────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // App bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'CATEGORIES',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 28), // balance spacer
                    ],
                  ),
                ),

                // "SELECT CATEGORIES" label
                const Padding(
                  padding: EdgeInsets.only(left: 18, right: 18, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ANYBODY LOOKING FOR?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),

                // Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.92),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() => _query = v),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Search Here...',
                        hintStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black45,
                          size: 20,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Category list
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 4,
                    ),
                    itemCount: _filteredEntries.length,
                    separatorBuilder: (_, index) {
                      final entry = _filteredEntries[index];
                      return entry.isSectionTitle
                          ? const SizedBox(height: 16)
                          : const SizedBox(height: 6);
                    },
                    itemBuilder: (context, index) {
                      final entry = _filteredEntries[index];
                      if (entry.isSectionTitle) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 4),
                          child: Text(
                            entry.label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1,
                            ),
                          ),
                        );
                      }

                      return _CategoryRow(
                        label: entry.label,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SearchNationsScreen(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // Search World Wide button
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 16),
                  child: _SearchWorldWideButton(onTap: () {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Category section helpers ─────────────────────────────────────────────────

class _CategorySection {
  final String title;
  final List<String> items;
  const _CategorySection({required this.title, required this.items});
}

class _CategoryListEntry {
  final String label;
  final bool isSectionTitle;
  const _CategoryListEntry(this.label, {this.isSectionTitle = false});
}

// ── Category row ──────────────────────────────────────────────────────────────

class _CategoryRow extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _CategoryRow({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: const Color(0xFFCEC8DA).withOpacity(0.82),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black54, size: 20),
          ],
        ),
      ),
    );
  }
}

// ── Search World Wide button ──────────────────────────────────────────────────

class _SearchWorldWideButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SearchWorldWideButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFCEC8DA).withOpacity(0.88),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Globe emoji-style icon
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF0D47A1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.white54, width: 1),
              ),
              child: const Icon(Icons.language, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            const Text(
              'Search World Wide',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ],
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
    Offset(0.22, 0.30),
    Offset(0.66, 0.66),
    Offset(0.43, 0.22),
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
      Offset(size.width * 0.83, size.height * 0.25),
      2.0,
      bright,
    );
    canvas.drawCircle(
      Offset(size.width * 0.12, size.height * 0.58),
      1.8,
      bright,
    );
    canvas.drawCircle(
      Offset(size.width * 0.50, size.height * 0.36),
      1.5,
      bright,
    );
    canvas.drawCircle(
      Offset(size.width * 0.30, size.height * 0.74),
      1.6,
      bright,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
