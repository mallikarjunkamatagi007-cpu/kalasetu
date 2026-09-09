import 'dart:io';

import 'package:flutter/material.dart';

class AiListingScreen extends StatefulWidget {
  final File? productImage;

  const AiListingScreen({
    super.key,
    this.productImage,
  });

  @override
  State<AiListingScreen> createState() => _AiListingScreenState();
}

class _AiListingScreenState extends State<AiListingScreen> {
  // --------------------------------------------------------------------------
  // COLORS
  // --------------------------------------------------------------------------

  static const Color backgroundColor = Color(0xFFE8F3EF);
  static const Color cardColor = Color(0xFFF9FCFA);
  static const Color primaryColor = Color(0xFF126B68);
  static const Color darkText = Color(0xFF193B39);
  static const Color secondaryText = Color(0xFF6B7D7A);
  static const Color softMint = Color(0xFFD9EAE5);
  static const Color lightMint = Color(0xFFF0F7F4);

  // --------------------------------------------------------------------------
  // STATE
  // --------------------------------------------------------------------------

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

  // --------------------------------------------------------------------------
  // GENERATE AI LISTING
  // --------------------------------------------------------------------------

  Future<void> generateListing() async {
    if (widget.productImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add a product photo first.'),
        ),
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
      const SnackBar(
        content: Text('AI listing generated successfully!'),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // PUBLISH AI LISTING
  // --------------------------------------------------------------------------

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
        const SnackBar(
          content: Text('Please complete the listing details.'),
        ),
      );
      return;
    }

    final double? price =
        double.tryParse(priceController.text.trim());

    if (price == null || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid price.'),
        ),
      );
      return;
    }

    // Create product result
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

    // Return product to previous screen
    Navigator.pop(context, newProduct);
  }

  // --------------------------------------------------------------------------
  // BUILD
  // --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: darkText,
        title: const Text(
          'AI Product Listing',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: darkText,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------------------------------------------
            // AI HEADER
            // ----------------------------------------------------------------

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(21),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.16),
                    blurRadius: 18,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create Your Listing with AI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            height: 1.2,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Upload a photo and AI will help create a professional product listing for you.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 27),

            // ----------------------------------------------------------------
            // STEP 1
            // ----------------------------------------------------------------

            _buildStepTitle(
              '1',
              'Product Photo',
            ),

            const SizedBox(height: 13),

            Container(
              width: double.infinity,
              height: 265,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: softMint,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.025),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: widget.productImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            widget.productImage!,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: 12,
                            bottom: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 11,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.92),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle_rounded,
                                    size: 17,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Photo selected',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: darkText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            color: lightMint,
                            borderRadius: BorderRadius.circular(21),
                          ),
                          child: const Icon(
                            Icons.image_outlined,
                            size: 38,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'No product photo selected',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: darkText,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Add a photo to let AI analyze your craft.',
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryText,
                          ),
                        ),
                      ],
                    ),
            ),

            if (widget.productImage != null) ...[
              const SizedBox(height: 9),
              const Center(
                child: Text(
                  'Your selected product photo',
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryText,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 22),

            // ----------------------------------------------------------------
            // GENERATE BUTTON
            // ----------------------------------------------------------------

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
                    : const Icon(
                        Icons.auto_awesome_rounded,
                      ),
                label: Text(
                  generating
                      ? 'AI is Creating Your Listing...'
                      : 'Generate Listing with AI',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFF9BBAB6),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ----------------------------------------------------------------
            // GENERATED RESULT
            // ----------------------------------------------------------------

            if (generated) ...[
              _buildStepTitle(
                '2',
                'Review AI Generated Listing',
              ),

              const SizedBox(height: 14),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  17,
                  18,
                  17,
                  20,
                ),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: softMint,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.025),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
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
                          color: primaryColor,
                        ),
                        filled: true,
                        fillColor: lightMint,
                        contentPadding:
                            const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: softMint,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: softMint,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: primaryColor,
                            width: 1.4,
                          ),
                        ),
                      ),
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(
                            category,
                            style: const TextStyle(
                              fontSize: 14,
                              color: darkText,
                            ),
                          ),
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
                      icon: Icons.currency_rupee_rounded,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ----------------------------------------------------------------
              // AI PRICE RECOMMENDATION
              // ----------------------------------------------------------------

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: lightMint,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(
                    color: softMint,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: const Icon(
                        Icons.lightbulb_outline_rounded,
                        color: primaryColor,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Suggestion',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: darkText,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'The suggested price is based on the product type and typical market pricing. You can edit it before publishing.',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.5,
                              color: secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 23),

              // ----------------------------------------------------------------
              // PUBLISH
              // ----------------------------------------------------------------

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: publishListing,
                  icon: const Icon(
                    Icons.publish_outlined,
                  ),
                  label: const Text(
                    'Publish AI Listing',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],

            // ----------------------------------------------------------------
            // HOW AI HELPS
            // ----------------------------------------------------------------

            const Text(
              'How AI Helps',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),

            const SizedBox(height: 14),

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
              Icons.check_circle_outline_rounded,
              '4. Review & Publish',
              'You can edit everything before publishing your product.',
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // STEP TITLE
  // --------------------------------------------------------------------------

  Widget _buildStepTitle(
    String number,
    String title,
  ) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: darkText,
            ),
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // LABEL
  // --------------------------------------------------------------------------

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: darkText,
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // TEXT FIELD
  // --------------------------------------------------------------------------

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
      style: const TextStyle(
        fontSize: 14,
        color: darkText,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
        filled: true,
        fillColor: lightMint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: softMint,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: softMint,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: primaryColor,
            width: 1.4,
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // HELP CARD
  // --------------------------------------------------------------------------

  Widget _helpCard(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: softMint,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: lightMint,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: secondaryText,
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