import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  bool isFavorite = false;

  static const Color backgroundColor = Color(0xFFE8F3EF);
  static const Color cardColor = Color(0xFFF9FCFA);
  static const Color primaryColor = Color(0xFF126B68);
  static const Color darkText = Color(0xFF193B39);
  static const Color secondaryText = Color(0xFF6B7D7A);
  static const Color softMint = Color(0xFFD9EAE5);
  static const Color imageBackground = Color(0xFFEAF4F1);

  void addToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${widget.product['name']} added to cart',
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        action: SnackBarAction(
          label: 'VIEW CART',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: backgroundColor,

      // -------------------------------------------------------------------
      // App Bar
      // -------------------------------------------------------------------
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: darkText,
        titleSpacing: 20,
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: darkText,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: cardColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFDCE9E5),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                icon: Icon(
                  isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: isFavorite
                      ? const Color(0xFFE16B75)
                      : primaryColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),

      // -------------------------------------------------------------------
      // Body
      // -------------------------------------------------------------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------------------------------------------
            // Product Image
            // ----------------------------------------------------------------
            Container(
              height: 300,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(18, 8, 18, 20),
              decoration: BoxDecoration(
                color: imageBackground,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: const Color(0xFFDCEAE5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.035),
                    blurRadius: 18,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 145,
                      height: 145,
                      decoration: const BoxDecoration(
                        color: softMint,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        product['icon'] ??
                            Icons.handyman_outlined,
                        size: 82,
                        color: primaryColor,
                      ),
                    ),
                  ),

                  // Handmade badge
                  Positioned(
                    left: 15,
                    top: 15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome_outlined,
                            size: 14,
                            color: primaryColor,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Handmade',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ----------------------------------------------------------
                  // Category
                  // ----------------------------------------------------------
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: softMint,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      product['category'] ?? 'Handmade',
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ----------------------------------------------------------
                  // Product Name
                  // ----------------------------------------------------------
                  Text(
                    product['name'] ?? 'Handmade Product',
                    style: const TextStyle(
                      fontSize: 27,
                      height: 1.2,
                      fontWeight: FontWeight.w800,
                      color: darkText,
                      letterSpacing: -0.4,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ----------------------------------------------------------
                  // Artisan
                  // ----------------------------------------------------------
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: softMint,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Crafted by',
                              style: TextStyle(
                                fontSize: 10.5,
                                color: secondaryText,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              product['artisan'] ??
                                  'Local Artisan',
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: darkText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 17),

                  // ----------------------------------------------------------
                  // Rating
                  // ----------------------------------------------------------
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7E5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Color(0xFFE0A92E),
                          size: 19,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '4.8',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: darkText,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '(24 reviews)',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 17),

                  // ----------------------------------------------------------
                  // Price
                  // ----------------------------------------------------------
                  Text(
                    '₹${product['price'] ?? '0'}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ----------------------------------------------------------
                  // About Product
                  // ----------------------------------------------------------
                  const Text(
                    'About this product',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 9),

                  const Text(
                    'This beautiful handmade product is crafted '
                    'with care by a skilled artisan. Each piece '
                    'has its own unique character and supports '
                    'traditional craftsmanship and local communities.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: secondaryText,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ----------------------------------------------------------
                  // Product Information Card
                  // ----------------------------------------------------------
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(19),
                      border: Border.all(
                        color: const Color(0xFFDCE9E5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.025),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        InfoRow(
                          icon: Icons.eco_outlined,
                          title: 'Material',
                          value: 'Natural / Handmade',
                        ),
                        Divider(
                          height: 25,
                          color: Color(0xFFE2ECE9),
                        ),
                        InfoRow(
                          icon: Icons.location_on_outlined,
                          title: 'Made in',
                          value: 'India',
                        ),
                        Divider(
                          height: 25,
                          color: Color(0xFFE2ECE9),
                        ),
                        InfoRow(
                          icon: Icons.handyman_outlined,
                          title: 'Craft type',
                          value: 'Traditional Craft',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ----------------------------------------------------------
                  // Quantity
                  // ----------------------------------------------------------
                  const Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 11),

                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFDCE9E5),
                          ),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.remove_rounded,
                              ),
                              color: primaryColor,
                            ),

                            Container(
                              constraints:
                                  const BoxConstraints(
                                minWidth: 30,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '$quantity',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: darkText,
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              icon: const Icon(
                                Icons.add_rounded,
                              ),
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // ----------------------------------------------------------
                  // Add To Cart
                  // ----------------------------------------------------------
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: addToCart,
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 21,
                      ),
                      label: const Text(
                        'Add to Cart',
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

                  const SizedBox(height: 12),

                  // ----------------------------------------------------------
                  // Buy Now
                  // ----------------------------------------------------------
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content:
                                Text('Checkout coming soon'),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryColor,
                        side: const BorderSide(
                          color: primaryColor,
                          width: 1.2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ----------------------------------------------------------
                  // Support Artisan Message
                  // ----------------------------------------------------------
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F7F4),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFFDCEAE5),
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          size: 19,
                          color: primaryColor,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Every purchase helps support '
                            'independent artisans and preserve '
                            'traditional craftsmanship.',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.5,
                              color: secondaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// Product Information Row
// ===========================================================================

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  static const Color primaryColor = Color(0xFF126B68);
  static const Color darkText = Color(0xFF193B39);
  static const Color secondaryText = Color(0xFF6B7D7A);
  static const Color softMint = Color(0xFFD9EAE5);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: softMint,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            color: primaryColor,
            size: 19,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: darkText,
            ),
          ),
        ),

        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 12,
              color: secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}