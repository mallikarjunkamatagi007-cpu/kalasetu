import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
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
  // IMAGE PICKER
  // --------------------------------------------------------------------------

  final ImagePicker _picker = ImagePicker();

  File? _productImage;

  // --------------------------------------------------------------------------
  // OPEN CAMERA
  // --------------------------------------------------------------------------

  Future<void> _takePhoto() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _productImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open camera: $e'),
        ),
      );
    }
  }

  // --------------------------------------------------------------------------
  // OPEN GALLERY
  // --------------------------------------------------------------------------

  Future<void> _chooseFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _productImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open gallery: $e'),
        ),
      );
    }
  }

  // --------------------------------------------------------------------------
  // SHOW CAMERA / GALLERY OPTIONS
  // --------------------------------------------------------------------------

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Bottom sheet handle
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: softMint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Add Product Photo',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Choose how you want to add your product image',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: secondaryText,
                  ),
                ),

                const SizedBox(height: 20),

                // CAMERA
                _ImageOptionTile(
                  icon: Icons.camera_alt_outlined,
                  title: 'Take Photo',
                  subtitle: 'Use your phone camera',
                  onTap: () {
                    Navigator.pop(context);
                    _takePhoto();
                  },
                ),

                const SizedBox(height: 10),

                // GALLERY
                _ImageOptionTile(
                  icon: Icons.photo_library_outlined,
                  title: 'Choose from Gallery',
                  subtitle: 'Select an existing product photo',
                  onTap: () {
                    Navigator.pop(context);
                    _chooseFromGallery();
                  },
                ),

                const SizedBox(height: 10),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --------------------------------------------------------------------------
  // BUILD UI
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
          'Add New Product',
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
            // HEADER
            // ----------------------------------------------------------------

            const Text(
              'Create your listing',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Add your handmade product and share it with customers.',
              style: TextStyle(
                fontSize: 14,
                color: secondaryText,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 25),

            // ----------------------------------------------------------------
            // PRODUCT PHOTO
            // ----------------------------------------------------------------

            _SectionTitle(
              icon: Icons.image_outlined,
              title: 'Product Photo',
            ),

            const SizedBox(height: 12),

            GestureDetector(
              onTap: _showImageOptions,
              child: Container(
                width: double.infinity,
                height: 275,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: softMint,
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.025),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: _productImage == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 78,
                            height: 78,
                            decoration: BoxDecoration(
                              color: lightMint,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: const Icon(
                              Icons.add_a_photo_outlined,
                              size: 38,
                              color: primaryColor,
                            ),
                          ),

                          const SizedBox(height: 17),

                          const Text(
                            'Add Product Photo',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: darkText,
                            ),
                          ),

                          const SizedBox(height: 7),

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            child: Text(
                              'Tap to take a photo or choose one from your gallery',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.4,
                                color: secondaryText,
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: softMint,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Add Image',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: Image.file(
                              _productImage!,
                              width: double.infinity,
                              height: 275,
                              fit: BoxFit.cover,
                            ),
                          ),

                          // Change image button
                          Positioned(
                            right: 12,
                            bottom: 12,
                            child: GestureDetector(
                              onTap: _showImageOptions,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 13,
                                  vertical: 9,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.94),
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      size: 17,
                                      color: primaryColor,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'Change',
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
                          ),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 15),

            // ----------------------------------------------------------------
            // CAMERA + GALLERY BUTTONS
            // ----------------------------------------------------------------

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _takePhoto,
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 20,
                    ),
                    label: const Text('Take Photo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 11),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _chooseFromGallery,
                    icon: const Icon(
                      Icons.photo_library_outlined,
                      size: 20,
                    ),
                    label: const Text('Gallery'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      side: const BorderSide(
                        color: primaryColor,
                        width: 1.2,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ----------------------------------------------------------------
            // PRODUCT DETAILS
            // ----------------------------------------------------------------

            _SectionTitle(
              icon: Icons.inventory_2_outlined,
              title: 'Product Details',
            ),

            const SizedBox(height: 14),

            // Product name
            _StyledTextField(
              label: 'Product Name',
              hint: 'Enter product name',
              icon: Icons.sell_outlined,
            ),

            const SizedBox(height: 14),

            // Description
            _StyledTextField(
              label: 'Description',
              hint: 'Describe your handmade product',
              icon: Icons.description_outlined,
              maxLines: 4,
            ),

            const SizedBox(height: 25),

            // ----------------------------------------------------------------
            // INFORMATION CARD
            // ----------------------------------------------------------------

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: lightMint,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: softMint,
                ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb_outline_rounded,
                    color: primaryColor,
                    size: 21,
                  ),
                  SizedBox(width: 11),
                  Expanded(
                    child: Text(
                      'Use a clear product photo and describe what makes your handmade product special.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.45,
                        color: secondaryText,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ----------------------------------------------------------------
            // ADD PRODUCT BUTTON
            // ----------------------------------------------------------------

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Product details added successfully',
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add_rounded,
                  size: 22,
                ),
                label: const Text(
                  'Add Product',
                  style: TextStyle(
                    fontSize: 15,
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
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION TITLE
// ============================================================================

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionTitle({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: lightMint,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            size: 20,
            color: primaryColor,
          ),
        ),
        const SizedBox(width: 11),
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: darkText,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// IMAGE OPTION TILE
// ============================================================================

class _ImageOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ImageOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: lightMint,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: primaryColor,
                  size: 23,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: darkText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: secondaryText,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right_rounded,
                color: secondaryText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// STYLED TEXT FIELD
// ============================================================================

class _StyledTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final int maxLines;

  const _StyledTextField({
    required this.label,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(
        fontSize: 14,
        color: darkText,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            left: 12,
            right: maxLines > 1 ? 8 : 4,
          ),
          child: Icon(
            icon,
            size: 20,
            color: primaryColor,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 46,
        ),
        labelStyle: const TextStyle(
          color: secondaryText,
          fontSize: 13,
        ),
        floatingLabelStyle: const TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.w600,
        ),
        hintStyle: const TextStyle(
          color: Color(0xFF9AA9A6),
          fontSize: 13,
        ),
        filled: true,
        fillColor: cardColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 17,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: softMint,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: softMint,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: primaryColor,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}