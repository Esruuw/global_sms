import 'package:flutter/material.dart';



class savedpage extends StatelessWidget {
  const savedpage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saved Posts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SavedPostsScreen(),
    );
  }
}

class SavedPostsScreen extends StatefulWidget {
  const SavedPostsScreen({super.key});

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen> {
  final List<_PostItem> _posts = List.generate(
    5,
    (i) => _PostItem(
      id: i,
      description: 'Lorem Ipsum Dummy Text to be placed here...',
      price: '\$2',
    ),
  );

  void _deletePost(int id) {
    setState(() => _posts.removeWhere((p) => p.id == id));
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
                center: Alignment(0.5, 0.0),
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
          // Star field
          const _StarField(),

          // Foreground content
          SafeArea(
            child: Column(
              children: [
                // App bar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Hamburger
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white, size: 28),
                      ),
                      // Title
                      const Text(
                        'SAVED POSTS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      // Profile icon
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Icon(Icons.person_outline,
                            color: Colors.white, size: 22),
                      ),
                    ],
                  ),
                ),

                // Posts list
                Expanded(
                  child: _posts.isEmpty
                      ? const Center(
                          child: Text(
                            'No saved posts',
                            style: TextStyle(color: Colors.white54, fontSize: 16),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          itemCount: _posts.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final post = _posts[index];
                            return _SavedPostCard(
                              post: post,
                              onDelete: () => _deletePost(post.id),
                            );
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

// ── Data model ───────────────────────────────────────────────────────────────

class _PostItem {
  final int id;
  final String description;
  final String price;
  const _PostItem(
      {required this.id, required this.description, required this.price});
}

// ── Post card ────────────────────────────────────────────────────────────────

class _SavedPostCard extends StatefulWidget {
  final _PostItem post;
  final VoidCallback onDelete;

  const _SavedPostCard({required this.post, required this.onDelete});

  @override
  State<_SavedPostCard> createState() => _SavedPostCardState();
}

class _SavedPostCardState extends State<_SavedPostCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1040).withOpacity(0.82),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail placeholder
              Container(
                width: 78,
                height: 78,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white24),
                ),
                child: const _ImagePlaceholderIcon(),
              ),
              const SizedBox(width: 12),

              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          setState(() => _isExpanded = !_isExpanded),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: _isExpanded
                                  ? '${widget.post.description} Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                                  : widget.post.description,
                            ),
                            TextSpan(
                              text: _isExpanded ? ' Show Less' : 'Read More',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Delete icon
              GestureDetector(
                onTap: () => _confirmDelete(context),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.white70,
                  size: 22,
                ),
              ),
            ],
          ),

          // Price tag bottom-right
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 2),
            child: Text(
              widget.post.price,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2A1050),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Post',
            style: TextStyle(color: Colors.white)),
        content: const Text('Remove this saved post?',
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child:
                const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete',
                style: TextStyle(color: Color(0xFFCF6679))),
          ),
        ],
      ),
    );
    if (confirmed == true) widget.onDelete();
  }
}

// ── Image placeholder icon ───────────────────────────────────────────────────

class _ImagePlaceholderIcon extends StatelessWidget {
  const _ImagePlaceholderIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ThumbnailPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _ThumbnailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Outer rounded rect (already done by container)
    // Circle (sun/lens)
    canvas.drawCircle(Offset(cx - 8, cy - 10), 10, paint);

    // Mountain/landscape lines
    final path = Path()
      ..moveTo(left + 8, size.height - 18)
      ..lineTo(size.width * 0.35, cy - 2)
      ..lineTo(size.width * 0.55, cy + 10)
      ..lineTo(size.width * 0.75, cy - 8)
      ..lineTo(size.width - 8, size.height - 18);
    canvas.drawPath(path, paint);
  }

  double get left => 0;

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
    Offset(0.05, 0.05), Offset(0.14, 0.18), Offset(0.27, 0.04),
    Offset(0.39, 0.12), Offset(0.53, 0.02), Offset(0.67, 0.16),
    Offset(0.79, 0.06), Offset(0.91, 0.21), Offset(0.97, 0.09),
    Offset(0.08, 0.37), Offset(0.21, 0.50), Offset(0.35, 0.46),
    Offset(0.49, 0.57), Offset(0.62, 0.43), Offset(0.75, 0.55),
    Offset(0.88, 0.48), Offset(0.04, 0.67), Offset(0.16, 0.78),
    Offset(0.32, 0.70), Offset(0.46, 0.83), Offset(0.60, 0.73),
    Offset(0.73, 0.86), Offset(0.85, 0.76), Offset(0.97, 0.90),
    Offset(0.11, 0.93), Offset(0.54, 0.91), Offset(0.79, 0.63),
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
    canvas.drawCircle(Offset(size.width * 0.52, size.height * 0.40), 1.5, bright);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}