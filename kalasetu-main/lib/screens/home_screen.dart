import 'package:flutter/material.dart';

import 'categories_screen.dart';
import 'search_screen.dart';
import 'product_details_screen.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';
import 'wishlist_screen.dart';
import 'profile_screen.dart';
import '../widgets/app_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  // Existing product data kept intact.
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Handcrafted Clay Pot',
      'artisan': 'Meera Crafts',
      'category': 'Pottery',
      'price': 650,
      'rating': 4.8,
      'reviews': 32,
      'icon': Icons.local_florist,
    },
    {
      'name': 'Traditional Handwoven Basket',
      'artisan': 'Rajasthan Artisans',
      'category': 'Baskets',
      'price': 850,
      'rating': 4.7,
      'reviews': 24,
      'icon': Icons.shopping_basket,
    },
    {
      'name': 'Handmade Cotton Shawl',
      'artisan': 'Kashmir Crafts',
      'category': 'Textiles',
      'price': 1200,
      'rating': 4.9,
      'reviews': 41,
      'icon': Icons.checkroom,
    },
    {
      'name': 'Terracotta Decorative Diya',
      'artisan': 'Village Crafts',
      'category': 'Decor',
      'price': 350,
      'rating': 4.6,
      'reviews': 18,
      'icon': Icons.light_mode,
    },
  ];

  // Main colors inspired by the reference image.
  static const Color backgroundColor = Color(0xFFE8F3EF);
  static const Color cardColor = Color(0xFFF9FCFA);
  static const Color primaryColor = Color(0xFF126B68);
  static const Color darkText = Color(0xFF193B39);
  static const Color secondaryText = Color(0xFF6B7D7A);
  static const Color softMint = Color(0xFFD9EAE5);
  static const Color lightMint = Color(0xFFF0F7F4);

  void onNavigationTap(int index) {
    setState(() {
      currentIndex = index;
    });

    switch (index) {
      case 0:
        break;

      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CategoriesScreen(),
          ),
        );
        break;

      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OrdersScreen(),
          ),
        );
        break;

      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
        break;
    }
  }

  void openProduct(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product),
      ),
    );
  }

  void openWishlist() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WishlistScreen(),
      ),
    );
  }

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CartScreen(),
      ),
    );
  }

  void openSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchScreen(),
      ),
    );
  }

  void openCategories() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CategoriesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // ------------------------------------------------------------
      // TOP BAR
      // ------------------------------------------------------------
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: 74,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'KalaSetu',
                  style: TextStyle(
                    color: darkText,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Handmade with heart',
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          _topIconButton(
            icon: Icons.favorite_border_rounded,
            onTap: openWishlist,
          ),
          const SizedBox(width: 4),
          _topIconButton(
            icon: Icons.shopping_bag_outlined,
            onTap: openCart,
          ),
          const SizedBox(width: 14),
        ],
      ),

      // ------------------------------------------------------------
      // BODY
      // ------------------------------------------------------------
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ----------------------------------------------------
              // WELCOME
              // ----------------------------------------------------
              const Text(
                'Discover Handmade',
                style: TextStyle(
                  color: darkText,
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 3),

              const Text(
                'Treasures',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Discover unique crafts made by talented artisans.',
                style: TextStyle(
                  color: secondaryText,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 20),

              // ----------------------------------------------------
              // SEARCH BAR
              // ----------------------------------------------------
              GestureDetector(
                onTap: openSearch,
                child: Container(
                  height: 54,
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                      color: const Color(0xFFD7E5E1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.035),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: primaryColor,
                        size: 23,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Search handmade products...',
                          style: TextStyle(
                            color: secondaryText,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.tune_rounded,
                        color: secondaryText,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ----------------------------------------------------
              // AI FEATURE CARD
              // ----------------------------------------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: softMint,
                  borderRadius: BorderRadius.circular(21),
                  border: Border.all(
                    color: const Color(0xFFC8DDD7),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create with AI',
                            style: TextStyle(
                              color: darkText,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Turn a simple product photo into a professional listing.',
                            style: TextStyle(
                              color: secondaryText,
                              fontSize: 11.5,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: primaryColor,
                      size: 16,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 27),

              // ----------------------------------------------------
              // CATEGORY TITLE
              // ----------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      color: darkText,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  GestureDetector(
                    onTap: openCategories,
                    child: const Text(
                      'View all',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ----------------------------------------------------
              // CATEGORIES
              // ----------------------------------------------------
              SizedBox(
                height: 108,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _category(
                      'Pottery',
                      Icons.local_florist_rounded,
                    ),
                    _category(
                      'Textiles',
                      Icons.checkroom_rounded,
                    ),
                    _category(
                      'Baskets',
                      Icons.shopping_basket_outlined,
                    ),
                    _category(
                      'Jewellery',
                      Icons.diamond_outlined,
                    ),
                    _category(
                      'Decor',
                      Icons.home_outlined,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ----------------------------------------------------
              // FEATURED PRODUCTS HEADER
              // ----------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Featured Products',
                    style: TextStyle(
                      color: darkText,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  GestureDetector(
                    onTap: openCategories,
                    child: const Text(
                      'See more',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ----------------------------------------------------
              // PRODUCT GRID
              // ----------------------------------------------------
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];

                  return _productCard(product);
                },
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),

      // ------------------------------------------------------------
      // EXISTING BOTTOM NAVIGATION
      // ------------------------------------------------------------
      bottomNavigationBar: AppBottomNav(
        currentIndex: currentIndex,
        onTap: onNavigationTap,
      ),
    );
  }

  // ================================================================
  // TOP ICON BUTTON
  // ================================================================

  Widget _topIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: const Color(0xFFD7E5E1),
            ),
          ),
          child: Icon(
            icon,
            color: darkText,
            size: 21,
          ),
        ),
      ),
    );
  }

  // ================================================================
  // CATEGORY CARD
  // ================================================================

  Widget _category(String name, IconData icon) {
    return GestureDetector(
      onTap: openCategories,
      child: Container(
        width: 86,
        margin: const EdgeInsets.only(right: 11),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFD8E6E2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: lightMint,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                size: 23,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: darkText,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // PRODUCT CARD
  // ================================================================

  Widget _productCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () => openProduct(product),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(
            color: const Color(0xFFD9E6E2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // --------------------------------------------------------
            // PRODUCT IMAGE AREA
            // --------------------------------------------------------
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: lightMint,
                    ),
                    child: Center(
                      child: Container(
                        width: 76,
                        height: 76,
                        decoration: BoxDecoration(
                          color: softMint,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          product['icon'] as IconData,
                          size: 39,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),

                  // Favorite button
                  Positioned(
                    top: 9,
                    right: 9,
                    child: Container(
                      width: 31,
                      height: 31,
                      decoration: BoxDecoration(
                        color: cardColor.withOpacity(0.92),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border_rounded,
                        color: primaryColor,
                        size: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --------------------------------------------------------
            // PRODUCT DETAILS
            // --------------------------------------------------------
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(11, 9, 11, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Category
                    Text(
                      product['category'],
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Name
                    Text(
                      product['name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: darkText,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Artisan
                    Text(
                      product['artisan'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: secondaryText,
                        fontSize: 10,
                      ),
                    ),

                    const Spacer(),

                    // Rating + Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFE2A62D),
                              size: 14,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${product['rating']}',
                              style: const TextStyle(
                                color: darkText,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),

                        Text(
                          '₹${product['price']}',
                          style: const TextStyle(
                            color: primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}