import 'dart:io';

import 'package:flutter/material.dart';

class AiListingScreen extends StatefulWidget {
  final File? productImage;

  const AiListingScreen({super.key, this.productImage});

  @override
  State<AiListingScreen> createState() => _AiListingScreenState();
}

class _AiListingScreenState extends State<AiListingScreen> {
  bool generating = false;
  bool generated = false;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final tagsController = TextEditingController();
  final priceController = TextEditingController();

  String selectedCategory = 'Pottery';

  final List<String> categories = [
    'Handicrafts',
    'Textiles',
    'Jewellery',
    'Pottery',
    'Woodwork',
    'Paintings',
    'Home Decor',
    'Bags',
  ];

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    tagsController.dispose();
    priceController.dispose();
    super.dispose();
  }

  // ------------------------------------------------
  // GENERATE AI LISTING
  // ------------------------------------------------

  Future<void> generateListing() async {
    if (widget.productImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a product photo first.')),
      );
      return;
    }

    setState(() {
      generating = true;
      generated = false;
    });

    // Temporary AI simulation.
    // Real Gemini AI will be connected later.
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      generating = false;
      generated = true;

      nameController.text = 'Handcrafted Traditional Clay Pot';

      descriptionController.text =
          'A beautifully handcrafted clay pot made by '
          'skilled artisans using traditional pottery '
          'techniques. Perfect for home decoration, '
          'plants, and adding a touch of traditional '
          'Indian craftsmanship to your space.';

      tagsController.text =
          'handmade, pottery, clay, traditional, '
          'Indian craft, home decor';

      priceController.text = '650';

      selectedCategory = 'Pottery';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('AI listing generated successfully!')),
    );
  }

  // ------------------------------------------------
  // PUBLISH AI LISTING
  // ------------------------------------------------

  void publishListing() {
    if (!generated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Generate the AI listing before publishing.'),
        ),
      );
      return;
    }

    if (nameController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the listing details.')),
      );
      return;
    }

    final double? price = double.tryParse(priceController.text.trim());

    if (price == null || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid price.')),
      );
      return;
    }

    // ------------------------------------------------
    // CREATE PRODUCT RESULT
    // ------------------------------------------------

    final Map<String, dynamic> newProduct = {
      'name': nameController.text.trim(),
      'category': selectedCategory,
      'description': descriptionController.text.trim(),
      'tags': tagsController.text.trim(),
      'price': price,
      'stock': 1,
      'sales': 0,
      'image': widget.productImage,
      'icon': Icons.inventory_2_outlined,
      'active': true,
    };

    // ------------------------------------------------
    // RETURN PRODUCT TO ADD PRODUCT SCREEN
    // ------------------------------------------------

    Navigator.pop(context, newProduct);
  }

  // ------------------------------------------------
  // BUILD
  // ------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F0),
        elevation: 0,
        foregroundColor: const Color(0xFF5D2E0C),
        title: const Text(
          'AI Product Listing',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------------------------------
            // AI HEADER
            // ------------------------------------------------

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF8B4513),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.white, size: 32),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Create Your Listing with AI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Upload a photo and AI will help create '
                    'a professional product listing for you.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ------------------------------------------------
            // STEP 1
            // ------------------------------------------------
            _buildStepTitle('1', 'Product Photo'),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              height: 260,
              decoration: BoxDecoration(
                color: const Color(0xFFF5E6D3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE8D8C8)),
              ),
              child: widget.productImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        widget.productImage!,
                        width: double.infinity,
                        height: 260,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.image_outlined,
                          size: 65,
                          color: Color(0xFF8B4513),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'No product photo selected',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5D2E0C),
                          ),
                        ),
                      ],
                    ),
            ),

            const SizedBox(height: 10),

            if (widget.productImage != null)
              const Center(
                child: Text(
                  'Your selected product photo',
                  style: TextStyle(fontSize: 12, color: Color(0xFF795548)),
                ),
              ),

            const SizedBox(height: 25),

            // ------------------------------------------------
            // GENERATE BUTTON
            // ------------------------------------------------
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: generating ? null : generateListing,
                icon: generating
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.auto_awesome),
                label: Text(
                  generating
                      ? 'AI is Creating Your Listing...'
                      : 'Generate Listing with AI',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B4513),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFFBCAAA4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ------------------------------------------------
            // GENERATED RESULT
            // ------------------------------------------------
            if (generated) ...[
              _buildStepTitle('2', 'Review AI Generated Listing'),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE8D8C8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Product Name'),

                    _buildTextField(
                      controller: nameController,
                      icon: Icons.shopping_bag_outlined,
                    ),

                    const SizedBox(height: 18),

                    _buildLabel('Category'),

                    DropdownButtonFormField<String>(
                      initialValue: selectedCategory,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.category_outlined,
                          color: Color(0xFF8B4513),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFFFF8F0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedCategory = value;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 18),

                    _buildLabel('Description'),

                    _buildTextField(
                      controller: descriptionController,
                      icon: Icons.description_outlined,
                      maxLines: 5,
                    ),

                    const SizedBox(height: 18),

                    _buildLabel('Tags'),

                    _buildTextField(
                      controller: tagsController,
                      icon: Icons.tag_outlined,
                      maxLines: 2,
                    ),

                    const SizedBox(height: 18),

                    _buildLabel('Suggested Price'),

                    _buildTextField(
                      controller: priceController,
                      icon: Icons.currency_rupee,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // AI PRICE RECOMMENDATION
              // ------------------------------------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5E6D3),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Color(0xFF8B4513),
                      size: 30,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Suggestion',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5D2E0C),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'The suggested price is based on '
                            'the product type and typical '
                            'market pricing. You can edit '
                            'it before publishing.',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.5,
                              color: Color(0xFF795548),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // PUBLISH
              // ------------------------------------------------
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: publishListing,
                  icon: const Icon(Icons.publish_outlined),
                  label: const Text(
                    'Publish AI Listing',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B4513),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 30),

            // ------------------------------------------------
            // HOW AI WORKS
            // ------------------------------------------------
            const Text(
              'How AI Helps',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D2E0C),
              ),
            ),

            const SizedBox(height: 15),

            _helpCard(
              Icons.image_search_outlined,
              '1. Analyze Photo',
              'AI identifies the type and visual characteristics of your craft.',
            ),

            _helpCard(
              Icons.edit_note_outlined,
              '2. Create Listing',
              'AI generates a professional name and product description.',
            ),

            _helpCard(
              Icons.sell_outlined,
              '3. Suggest Price',
              'AI provides a suggested price range based on the product.',
            ),

            _helpCard(
              Icons.check_circle_outline,
              '4. Review & Publish',
              'You can edit everything before publishing your product.',
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------
  // STEP TITLE
  // ------------------------------------------------

  Widget _buildStepTitle(String number, String title) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: Color(0xFF8B4513),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D2E0C),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------
  // LABEL
  // ------------------------------------------------

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF5D2E0C),
        ),
      ),
    );
  }

  // ------------------------------------------------
  // TEXT FIELD
  // ------------------------------------------------

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF8B4513)),
        filled: true,
        fillColor: const Color(0xFFFFF8F0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE8D8C8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE8D8C8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF8B4513), width: 2),
        ),
      ),
    );
  }

  // ------------------------------------------------
  // HELP CARD
  // ------------------------------------------------

  Widget _helpCard(IconData icon, String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE8D8C8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: Color(0xFFF5E6D3),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF8B4513)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D2E0C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF795548),
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
