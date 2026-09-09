import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  static const Color backgroundColor = Color(0xFFE8F3EF);
  static const Color cardColor = Color(0xFFF9FCFA);
  static const Color primaryColor = Color(0xFF126B68);
  static const Color darkText = Color(0xFF193B39);
  static const Color secondaryText = Color(0xFF6B7D7A);
  static const Color softMint = Color(0xFFD9EAE5);
  static const Color imageBackground = Color(0xFFEAF4F1);

  final List<Map<String, dynamic>> wishlist = [
    {
      'name': 'Handmade Clay Pot',
      'artisan': 'Meera Crafts',
      'price': 450.0,
      'category': 'Pottery',
      'icon': Icons.local_florist_outlined,
    },
    {
      'name': 'Handcrafted Necklace',
      'artisan': 'Asha Jewellery',
      'price': 950.0,
      'category': 'Jewellery',
      'icon': Icons.diamond_outlined,
    },
    {
      'name': 'Traditional Saree',
      'artisan': 'Sita Handlooms',
      'price': 1800.0,
      'category': 'Textiles',
      'icon': Icons.checkroom_outlined,
    },
    {
      'name': 'Wooden Decorative Box',
      'artisan': 'Ravi Woodworks',
      'price': 750.0,
      'category': 'Woodwork',
      'icon': Icons.inventory_2_outlined,
    },
  ];

  void removeFromWishlist(int index) {
    final productName = wishlist[index]['name'];

    setState(() {
      wishlist.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$productName removed from wishlist'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void addToCart(String productName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$productName added to cart'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // ---------------------------------------------------------------
      // App Bar
      // ---------------------------------------------------------------
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: darkText,
        titleSpacing: 20,
        title: const Row(
          children: [
            Text(
              'Wishlist',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),
          ],
        ),
        actions: [
          if (wishlist.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(right: 18),
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: softMint,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${wishlist.length} items',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                ),
              ),
            ),
        ],
      ),

      // ---------------------------------------------------------------
      // Body
      // ---------------------------------------------------------------
      body: wishlist.isEmpty
          ? _buildEmptyWishlist()
          : GridView.builder(
              padding: const EdgeInsets.fromLTRB(
                17,
                8,
                17,
                25,
              ),
              itemCount: wishlist.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 13,
                mainAxisSpacing: 15,
                childAspectRatio: 0.64,
              ),
              itemBuilder: (context, index) {
                final product = wishlist[index];

                return _buildProductCard(
                  product,
                  index,
                );
              },
            ),
    );
  }

  // -----------------------------------------------------------------------
  // Product Card
  // -----------------------------------------------------------------------

  Widget _buildProductCard(
    Map<String, dynamic> product,
    int index,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: const Color(0xFFDCE9E5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------------------------------------------------------------
          // Product Image Area
          // -------------------------------------------------------------
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: imageBackground,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(21),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 78,
                      height: 78,
                      decoration: BoxDecoration(
                        color: softMint,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        product['icon'],
                        size: 42,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),

                // -------------------------------------------------------
                // Wishlist Remove Button
                // -------------------------------------------------------
                Positioned(
                  top: 9,
                  right: 9,
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    elevation: 1,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        removeFromWishlist(index);
                      },
                      child: const SizedBox(
                        width: 38,
                        height: 38,
                        child: Icon(
                          Icons.favorite_rounded,
                          color: Color(0xFFE16B75),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // -------------------------------------------------------------
          // Product Information
          // -------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(
              12,
              11,
              12,
              12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: softMint,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    product['category'],
                    style: const TextStyle(
                      fontSize: 9.5,
                      color: primaryColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                const SizedBox(height: 7),

                // Product Name
                Text(
                  product['name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w800,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 6),

                // Artisan
                Row(
                  children: [
                    const Icon(
                      Icons.storefront_outlined,
                      size: 13,
                      color: secondaryText,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        product['artisan'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10.5,
                          color: secondaryText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Price
                Text(
                  '₹${product['price'].toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 9),

                // Add to Cart
                SizedBox(
                  width: double.infinity,
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () {
                      addToCart(product['name']);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
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

  // -----------------------------------------------------------------------
  // Empty Wishlist
  // -----------------------------------------------------------------------

  Widget _buildEmptyWishlist() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: const BoxDecoration(
                color: softMint,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 55,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Your Wishlist is Empty',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Save your favourite handmade products here '
              'and come back to them anytime.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: secondaryText,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 9,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F7F4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_rounded,
                    size: 15,
                    color: primaryColor,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Your saved items will appear here',
                    style: TextStyle(
                      fontSize: 11,
                      color: secondaryText,
                      fontWeight: FontWeight.w600,
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