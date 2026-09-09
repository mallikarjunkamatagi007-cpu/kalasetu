import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
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
      SnackBar(content: Text('$productName removed from wishlist')),
    );
  }

  void addToCart(String productName) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$productName added to cart')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F0),
        elevation: 0,
        foregroundColor: const Color(0xFF5D2E0C),
        title: const Text(
          'Wishlist',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (wishlist.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Center(
                child: Text(
                  '${wishlist.length} items',
                  style: const TextStyle(
                    color: Color(0xFF795548),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),

      body: wishlist.isEmpty
          ? _buildEmptyWishlist()
          : GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: wishlist.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, index) {
                final product = wishlist[index];

                return _buildProductCard(product, index);
              },
            ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8D8C8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5E6D3),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                  ),
                  child: Icon(
                    product['icon'],
                    size: 60,
                    color: const Color(0xFF8B4513),
                  ),
                ),

                // Remove Button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        removeFromWishlist(index);
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                        size: 21,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Product Information
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['category'],
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF8B4513),
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  product['name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D2E0C),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  product['artisan'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF795548),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  '₹${product['price'].toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B4513),
                  ),
                ),

                const SizedBox(height: 10),

                // Add to Cart
                SizedBox(
                  width: double.infinity,
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () {
                      addToCart(product['name']);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B4513),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
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
                color: Color(0xFFF5E6D3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border,
                size: 60,
                color: Color(0xFF8B4513),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Your Wishlist is Empty',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D2E0C),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Save your favourite handmade products here '
              'and come back to them anytime.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Color(0xFF795548),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
