import 'package:flutter/material.dart';
import 'package:main/postview/postview.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _selectedNavIndex = 2; // Category selected by default

  final List<_NavItem> _navItems = const [
    _NavItem(icon: Icons.language, label: 'Global'),
    _NavItem(icon: Icons.home, label: 'Home'),
    _NavItem(icon: Icons.grid_view, label: 'Category'),
    _NavItem(icon: Icons.shopping_cart_outlined, label: 'Cart'),
    _NavItem(icon: Icons.add_circle_outline, label: 'Post'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Galaxy/Space background
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.3, -0.5),
                radius: 1.2,
                colors: [
                  Color(0xFF6B1FA8),
                  Color(0xFF3A0D6E),
                  Color(0xFF1A0A3A),
                  Color(0xFF0A0520),
                ],
                stops: [0.0, 0.35, 0.65, 1.0],
              ),
            ),
          ),
          // Stars overlay
          const _StarField(),

          // Main content
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      // Search bar
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: const Row(
                            children: [
                              SizedBox(width: 12),
                              Icon(Icons.search, color: Colors.grey),
                              SizedBox(width: 8),
                              Text(
                                'Search Here!',
                                style: TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Profile icon
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.person_outline, color: Colors.black87),
                      ),
                    ],
                  ),
                ),

                // Navigation bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A1550).withOpacity(0.85),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(_navItems.length, (index) {
                        final item = _navItems[index];
                        final isSelected = index == _selectedNavIndex;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedNavIndex = index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFD4C84A)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  item.icon,
                                  color: isSelected ? Colors.black87 : Colors.white70,
                                  size: 22,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item.label,
                                  style: TextStyle(
                                    color: isSelected ? Colors.black87 : Colors.white70,
                                    fontSize: 10,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),

                // Info text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'SEARCH BY PHONE, LOCATION, USERNAME OR USER ID. LEAVE A VOICE INTRO AND SCHEDULE A VIDEO MEET.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),

                // Results count
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    '12 results found',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                // Grid of cards
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.82,
                    ),
                    itemCount: 12,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const BlackLampScreen(),
                          ),
                        );
                      },
                      child: const _BusinessCard(),
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

class _BusinessCard extends StatefulWidget {
  const _BusinessCard();

  @override
  State<_BusinessCard> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<_BusinessCard> {
  bool _isFavorited = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFB0AAAA).withOpacity(0.82),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Personal Business',
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                    Text(
                      'Addis Abeba',
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _isFavorited = !_isFavorited),
                child: Icon(
                  _isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorited ? Colors.red : Colors.grey,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Expanded(
            child: Text(
              'Use the visual style of the last page card Use the visual style of the last page card',
              style: TextStyle(
                fontSize: 11,
                color: Colors.black87,
                height: 1.4,
              ),
              overflow: TextOverflow.fade,
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '\$2PV',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Simple decorative star field painted on canvas
class _StarField extends StatelessWidget {
  const _StarField();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _StarPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _StarPainter extends CustomPainter {
  static const List<Offset> _starPositions = [
    Offset(0.05, 0.08), Offset(0.12, 0.22), Offset(0.25, 0.05),
    Offset(0.38, 0.15), Offset(0.52, 0.03), Offset(0.65, 0.18),
    Offset(0.78, 0.07), Offset(0.90, 0.25), Offset(0.95, 0.12),
    Offset(0.08, 0.40), Offset(0.20, 0.55), Offset(0.35, 0.48),
    Offset(0.48, 0.60), Offset(0.62, 0.45), Offset(0.75, 0.58),
    Offset(0.88, 0.50), Offset(0.03, 0.70), Offset(0.15, 0.80),
    Offset(0.30, 0.72), Offset(0.45, 0.85), Offset(0.60, 0.75),
    Offset(0.72, 0.88), Offset(0.85, 0.78), Offset(0.97, 0.92),
    Offset(0.10, 0.95), Offset(0.55, 0.92), Offset(0.80, 0.65),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.7);
    for (int i = 0; i < _starPositions.length; i++) {
      final pos = _starPositions[i];
      final radius = (i % 3 == 0) ? 1.5 : (i % 3 == 1) ? 1.0 : 0.7;
      canvas.drawCircle(
        Offset(pos.dx * size.width, pos.dy * size.height),
        radius,
        paint,
      );
    }

    // A few brighter/larger stars
    final brightPaint = Paint()..color = Colors.white.withOpacity(0.95);
    canvas.drawCircle(Offset(size.width * 0.82, size.height * 0.30), 2.2, brightPaint);
    canvas.drawCircle(Offset(size.width * 0.18, size.height * 0.65), 2.0, brightPaint);
    canvas.drawCircle(Offset(size.width * 0.50, size.height * 0.50), 1.8, brightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}