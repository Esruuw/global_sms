import 'package:flutter/material.dart';
import 'package:main/managerpage/managerpage.dart';
import 'package:main/savedpage/savedpage.dart';

// class CreatePostApp extends StatelessWidget {
//   const CreatePostApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Create Post',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(useMaterial3: true),
//       home: const CreatePostScreen(),
//     );
//   }
// }

// ── Screen ───────────────────────────────────────────────────────────────────

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController(
    text: 'Addis Abeba, Ethiopia',
  );
  final _sendToController = TextEditingController();

  String? _selectedCategory;
  final List<String> _categories = [
    'Technology',
    'Business',
    'Love Story',
    'Health',
    'Sports',
  ];

  // Sub-categories (radio-style single select)
  String _selectedSubCategory = 'Technology';
  final List<String> _subCategories = ['Technology', 'Business', 'Love Story'];

  // Upload image slots
  bool _image1Uploaded = false;
  bool _image2Uploaded = false;

  // Notify toggle
  bool _notifyYes = true;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _locationController.dispose();
    _sendToController.dispose();
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
                center: Alignment(0.4, -0.1),
                radius: 1.5,
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
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const Text(
                        'CREATE POST',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SavedPostsScreen(),
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

                // ── Scrollable form ──────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        _SectionLabel('Title'),
                        const SizedBox(height: 6),
                        _FormField(
                          controller: _titleController,
                          hint: 'Title...',
                          maxLines: 1,
                        ),
                        const SizedBox(height: 14),

                        // Description
                        _SectionLabel('Description'),
                        const SizedBox(height: 6),
                        _FormField(
                          controller: _descController,
                          hint: 'Write details about your video chat topic....',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 14),

                        // Categories dropdown
                        _SectionLabel('Categories'),
                        const SizedBox(height: 6),
                        _DropdownField(
                          value: _selectedCategory,
                          hint: 'Select Categories',
                          items: _categories,
                          onChanged: (val) =>
                              setState(() => _selectedCategory = val),
                        ),
                        const SizedBox(height: 14),

                        // Sub Categories
                        _SectionLabel('Sub Categories'),
                        const SizedBox(height: 8),
                        ..._subCategories.map(
                          (cat) => _SubCategoryRow(
                            label: cat,
                            isSelected: _selectedSubCategory == cat,
                            onTap: () =>
                                setState(() => _selectedSubCategory = cat),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Upload Image
                        _SectionLabel('Upload Image'),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: _ImageUploadBox(
                                isUploaded: _image1Uploaded,
                                onTap: () => setState(
                                  () => _image1Uploaded = !_image1Uploaded,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _ImageUploadBox(
                                isUploaded: _image2Uploaded,
                                onTap: () => setState(
                                  () => _image2Uploaded = !_image2Uploaded,
                                ),
                                showLabel: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Location
                        _SectionLabel('Location'),
                        const SizedBox(height: 6),
                        _IconFormField(
                          controller: _locationController,
                          icon: Icons.location_on_outlined,
                          hint: 'Addis Abeba, Ethiopia',
                        ),
                        const SizedBox(height: 10),
                        _IconFormField(
                          controller: _sendToController,
                          icon: Icons.person_outline,
                          hint: 'Send To(User name)',
                        ),
                        const SizedBox(height: 14),

                        // Video Meet Price
                        _SectionLabel('Video Meet Price'),
                        const SizedBox(height: 6),
                        const Text(
                          '\$2 per vido chat',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Notify when someone purchases me a video meet',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        const SizedBox(height: 12),

                        // Yes / No toggle
                        Row(
                          children: [
                            _RadioOption(
                              label: 'Yes',
                              selected: _notifyYes,
                              onTap: () => setState(() => _notifyYes = true),
                            ),
                            const SizedBox(width: 24),
                            _RadioOption(
                              label: 'No',
                              selected: !_notifyYes,
                              onTap: () => setState(() => _notifyYes = false),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),

                        // POST NOW button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (_) => const Managerpage(),
                              //   ),
                              // );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6B2FD9),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 8,
                              shadowColor: const Color(
                                0xFF6B2FD9,
                              ).withOpacity(0.5),
                            ),
                            child: const Text(
                              'POST NOW',
                              style: TextStyle(
                                fontSize: 16,
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

// ── Reusable widgets ─────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const _FormField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
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
        maxLines: maxLines,
        style: const TextStyle(color: Colors.black87, fontSize: 13.5),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black45, fontSize: 13.5),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _IconFormField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hint;

  const _IconFormField({
    required this.controller,
    required this.icon,
    required this.hint,
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
        style: const TextStyle(color: Colors.black87, fontSize: 13.5),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black54, fontSize: 13.5),
          prefixIcon: Icon(icon, color: Colors.black54, size: 20),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownField({
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFD8D0E8).withOpacity(0.85),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: const TextStyle(color: Colors.black45, fontSize: 13.5),
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
          dropdownColor: const Color(0xFFD8D0E8),
          style: const TextStyle(color: Colors.black87, fontSize: 13.5),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _SubCategoryRow extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SubCategoryRow({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

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
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : Colors.transparent,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF5A1090),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageUploadBox extends StatelessWidget {
  final bool isUploaded;
  final VoidCallback onTap;
  final bool showLabel;

  const _ImageUploadBox({
    required this.isUploaded,
    required this.onTap,
    this.showLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFFD8D0E8).withOpacity(0.78),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isUploaded ? const Color(0xFF7B3FF5) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: isUploaded
              ? const Icon(
                  Icons.check_circle,
                  color: Color(0xFF6B2FD9),
                  size: 32,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      showLabel ? Icons.image_outlined : Icons.add,
                      color: Colors.black54,
                      size: showLabel ? 28 : 26,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Upload Image',
                      style: TextStyle(color: Colors.black54, fontSize: 11.5),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _RadioOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _RadioOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? Colors.white : Colors.transparent,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: selected
                ? Center(
                    child: Container(
                      width: 9,
                      height: 9,
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
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
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
