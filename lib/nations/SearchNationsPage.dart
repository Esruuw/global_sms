import 'package:flutter/material.dart';
import 'package:main/login/CreateAccountView.dart';
import 'package:main/postview/postview.dart';
import 'package:main/search/searchscreen.dart';
// ── Screen ───────────────────────────────────────────────────────────────────

class SearchNationsScreen extends StatefulWidget {
  const SearchNationsScreen({super.key});

  @override
  State<SearchNationsScreen> createState() => _SearchNationsScreenState();
}

class _SearchNationsScreenState extends State<SearchNationsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  static const List<String> _allNations = [
    'USA',
    'Liechtenstein',
    'Luxembourg',
    'Ireland',
    'Switzerland',
    'Iceland',
    'Singapore',
    'Norway',
    'United States',
    'Denmark',
    'Netherlands',
    'Qatar',
    'Australia',
    'San Marino',
    'Sweden',
    'Austria',
    'Belgium',
    'Israel',
    'Germany',
    'United Kingdom',
    'Finland',
    'Canada',
    'United Arab Emirates',
    'Andorra',
    'New Zealand',
    'Malta',
    'France',
    'Italy',
    'Cyprus',
    'Spain',
    'Taiwan',
    'Slovenia',
    'Brunei',
    'South Korea',
    'Saudi Arabia',
    'Czech Republic',
    'Japan',
    'Estonia',
    'Lithuania',
    'Portugal',
    'Guyana',
    'Kuwait',
    'Bahrain',
    'Slovakia',
    'Poland',
    'Greece',
    'Croatia',
    'Barbados',
    'Hungary',
    'Latvia',
    'Uruguay',
    'Romania',
    'Antigua and Barbuda',
    'Saint Kitts and Nevis',
    'Seychelles',
    'Bulgaria',
    'Panama',
    'Palau',
    'Oman',
    'Costa Rica',
    'Maldives',
    'Turkey',
    'Trinidad and Tobago',
    'Russia',
    'Chile',
    'Serbia',
    'Montenegro',
    'Kazakhstan',
    'Saint Lucia',
    'Argentina',
    'Nauru',
    'Mexico',
    'Malaysia',
    'China',
    'Mauritius',
    'Grenada',
    'Dominican Republic',
    'Saint Vincent and the Grenadines',
    'Albania',
    'Turkmenistan',
    'Brazil',
    'North Macedonia',
    'Georgia',
    'Dominica',
    'Bosnia and Herzegovina',
    'Belarus',
    'Gabon',
    'Peru',
    'Armenia',
    'Jamaica',
    'Marshall Islands',
    'Colombia',
    'Moldova',
    'Kosovo',
    'Thailand',
    'Belize',
    'Azerbaijan',
    'Ecuador',
    'Mongolia',
    'Botswana',
    'Libya',
    'Suriname',
    'Fiji',
    'Paraguay',
    'South Africa',
    'Guatemala',
    'Ukraine',
    'Algeria',
    'Tonga',
    'Samoa',
    'Iraq',
    'Tuvalu',
    'El Salvador',
    'Cape Verde',
    'Lebanon',
    'Micronesia',
    'Indonesia',
    'Jordan',
    'Namibia',
    'Morocco',
    'Tunisia',
    'Vietnam',
    'Bolivia',
    'Eswatini',
    'Djibouti',
    'Sri Lanka',
    'Philippines',
    'Bhutan',
    'Iran',
    'São Tomé and Príncipe',
    'Uzbekistan',
    'Honduras',
    'Ghana',
    'Egypt',
    'Vanuatu',
    'Venezuela',
    'Ivory Coast',
    'Nicaragua',
    'Angola',
    'India',
    'Cambodia',
    'Kyrgyzstan',
    'Bangladesh',
    'Zimbabwe',
    'Mauritania',
    'Papua New Guinea',
    'Kenya',
    'Kiribati',
    'Haiti',
    'Palestine',
    'Congo',
    'Solomon Islands',
    'Laos',
    'Cameroon',
    'Senegal',
    'Comoros',
    'Guinea',
    'Pakistan',
    'Tajikistan',
    'Benin',
    'Nepal',
    'Timor-Leste',
    'Uganda',
    'Zambia',
    'Tanzania',
    'Guinea-Bissau',
    'Nigeria',
    'Chad',
    'Togo',
    'Burkina Faso',
    'Myanmar',
    'Rwanda',
    'Mali',
    'Lesotho',
    'Ethiopia',
    'Sierra Leone',
    'Liberia',
    'Gambia',
    'Syria',
    'Niger',
    'DR Congo',
    'Somalia',
    'Sudan',
    'Mozambique',
    'Eritrea',
    'North Korea',
    'Malawi',
    'Madagascar',
    'Central African Republic',
    'Burundi',
    'Yemen',
    'Afghanistan',
    'South Sudan',
  ];

  List<String> get _filtered => _query.isEmpty
      ? _allNations
      : _allNations
            .where((n) => n.toLowerCase().contains(_query.toLowerCase()))
            .toList();

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
                center: Alignment(0.6, 0.3),
                radius: 1.3,
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

          // ── Foreground ─────────────────────────────────────────────────
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          'SEARCH NATIONS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.2,
                          ),
                        ),
                      ),

                      const SizedBox(width: 28),
                    ],
                  ),
                ),

                // Scrollable body
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // World map image placeholder
                        _WorldMapCard(),
                        const SizedBox(height: 14),

                        // Welcome text
                        const Text(
                          'WELCOME TO THE UNIVERSE OF\nPOSTS FOR GLOBAL ZZ VMAIL-ING',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            height: 1.45,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Instruction above search
                        const Text(
                          'Each nation has its own forum, search by phone area code in the nation',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Search bar
                        Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.90),
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
                              hintText: 'Search WorlWide...',
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
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Nation list
                        ..._filtered.map(
                          (nation) => Padding(
                            padding: const EdgeInsets.only(bottom: 7),
                            child: _NationRow(
                              label: nation,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const GlobalVMailsScreen(),
                                  ),
                                );
                              },
                            ),
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

// ── World map card ────────────────────────────────────────────────────────────

class _WorldMapCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.93),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://www.bing.com/images/search?view=detailV2&ccid=PKBa7SLM&id=EFB0BDD58F21E861786379DC75FC046599B4726E&thid=OIP.PKBa7SLM90o5SxRN0PwvNAHaFS&mediaurl=https%3A%2F%2Fi.pinimg.com%2Foriginals%2Fd6%2Fb7%2F14%2Fd6b71417ffbb1aefec36c20aeec55ec2.jpg&exph=857&expw=1200&q=world+map&form=IRPRST&ck=F5D631C061249273175C921398FFE56B&selectedindex=12&itb=0&cw=1272&ch=596&ajaxhist=0&ajaxserp=0&cdnurl=https%3A%2F%2Fth.bing.com%2Fth%2Fid%2FR.3ca05aed22ccf74a394b144dd0fc2f34%3Frik%3DbnK0mWUE%252fHXceQ%26pid%3DImgRaw%26r%3D0&pivotparams=insightsToken%3Dccid_2urLCE9V*cp_E02D4E5DE8B774E5DF30F959EB00DB71*mid_C9BF733150DCDDF344E3E3DB5CAD14A290CCC5BF*thid_OIP.2urLCE9VYUtoW7vvySWI0wHaEy&vt=0&sim=11&iss=VSI&ajaxhist=0&ajaxserp=0',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.blueGrey.shade200,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.blueGrey.shade200,
                  child: const Center(
                    child: Text(
                      'Map unavailable',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.35),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            const Positioned(
              top: 6,
              left: 8,
              child: Text(
                'WORLD MAP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorldMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Ocean background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFB8D4E8),
    );

    final landPaint = Paint()..style = PaintingStyle.fill;

    // --- North America ---
    landPaint.color = const Color(0xFF8FBC5A);
    final na = Path()
      ..moveTo(size.width * 0.05, size.height * 0.15)
      ..lineTo(size.width * 0.22, size.height * 0.10)
      ..lineTo(size.width * 0.26, size.height * 0.20)
      ..lineTo(size.width * 0.24, size.height * 0.50)
      ..lineTo(size.width * 0.18, size.height * 0.60)
      ..lineTo(size.width * 0.10, size.height * 0.55)
      ..lineTo(size.width * 0.05, size.height * 0.40)
      ..close();
    canvas.drawPath(na, landPaint);

    // --- South America ---
    landPaint.color = const Color(0xFF6BAA3A);
    final sa = Path()
      ..moveTo(size.width * 0.18, size.height * 0.62)
      ..lineTo(size.width * 0.26, size.height * 0.60)
      ..lineTo(size.width * 0.27, size.height * 0.85)
      ..lineTo(size.width * 0.20, size.height * 0.92)
      ..lineTo(size.width * 0.15, size.height * 0.85)
      ..lineTo(size.width * 0.16, size.height * 0.68)
      ..close();
    canvas.drawPath(sa, landPaint);

    // --- Europe ---
    landPaint.color = const Color(0xFFD4A84B);
    final eu = Path()
      ..moveTo(size.width * 0.42, size.height * 0.12)
      ..lineTo(size.width * 0.55, size.height * 0.10)
      ..lineTo(size.width * 0.56, size.height * 0.30)
      ..lineTo(size.width * 0.48, size.height * 0.35)
      ..lineTo(size.width * 0.42, size.height * 0.28)
      ..close();
    canvas.drawPath(eu, landPaint);

    // --- Africa ---
    landPaint.color = const Color(0xFFD4884B);
    final af = Path()
      ..moveTo(size.width * 0.44, size.height * 0.36)
      ..lineTo(size.width * 0.56, size.height * 0.34)
      ..lineTo(size.width * 0.57, size.height * 0.75)
      ..lineTo(size.width * 0.50, size.height * 0.88)
      ..lineTo(size.width * 0.44, size.height * 0.78)
      ..lineTo(size.width * 0.42, size.height * 0.55)
      ..close();
    canvas.drawPath(af, landPaint);

    // --- Asia ---
    landPaint.color = const Color(0xFFB8C45A);
    final asia = Path()
      ..moveTo(size.width * 0.56, size.height * 0.10)
      ..lineTo(size.width * 0.88, size.height * 0.08)
      ..lineTo(size.width * 0.90, size.height * 0.15)
      ..lineTo(size.width * 0.85, size.height * 0.45)
      ..lineTo(size.width * 0.72, size.height * 0.55)
      ..lineTo(size.width * 0.60, size.height * 0.48)
      ..lineTo(size.width * 0.57, size.height * 0.32)
      ..close();
    canvas.drawPath(asia, landPaint);

    // --- Australia ---
    landPaint.color = const Color(0xFFD4A84B);
    final aus = Path()
      ..moveTo(size.width * 0.74, size.height * 0.60)
      ..lineTo(size.width * 0.88, size.height * 0.58)
      ..lineTo(size.width * 0.90, size.height * 0.78)
      ..lineTo(size.width * 0.78, size.height * 0.84)
      ..lineTo(size.width * 0.73, size.height * 0.74)
      ..close();
    canvas.drawPath(aus, landPaint);

    // Graticule lines (lat/lon grid)
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..strokeWidth = 0.5;
    // Horizontal
    for (double y = 0.25; y < 1.0; y += 0.25) {
      canvas.drawLine(
        Offset(0, size.height * y),
        Offset(size.width, size.height * y),
        gridPaint,
      );
    }
    // Vertical
    for (double x = 0.2; x < 1.0; x += 0.2) {
      canvas.drawLine(
        Offset(size.width * x, 0),
        Offset(size.width * x, size.height),
        gridPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Nation row ────────────────────────────────────────────────────────────────

class _NationRow extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NationRow({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: const Color(0xFFCEC8DA).withOpacity(0.78),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
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
