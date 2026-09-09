import 'package:flutter/material.dart';

class ArtisanProfileScreen extends StatelessWidget {
  const ArtisanProfileScreen({super.key});

  static const Color backgroundColor = Color(0xFFE8F3EF);
  static const Color cardColor = Color(0xFFF9FCFA);
  static const Color primaryColor = Color(0xFF126B68);
  static const Color darkText = Color(0xFF193B39);
  static const Color secondaryText = Color(0xFF6B7D7A);
  static const Color softMint = Color(0xFFD9EAE5);
  static const Color lightMint = Color(0xFFF0F7F4);

  static const List<Map<String, dynamic>> products = [
    {
      'name': 'Handmade Clay Pot',
      'price': '₹450',
      'icon': Icons.local_florist_outlined,
    },
    {
      'name': 'Decorative Clay Vase',
      'price': '₹650',
      'icon': Icons.local_florist,
    },
    {
      'name': 'Traditional Diya Set',
      'price': '₹300',
      'icon': Icons.light_mode_outlined,
    },
    {
      'name': 'Handmade Ceramic Bowl',
      'price': '₹550',
      'icon': Icons.ramen_dining_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: darkText,
        centerTitle: false,
        title: const Text(
          'Artisan Profile',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            color: darkText,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // ------------------------------------------------------------
            // PROFILE HEADER
            // ------------------------------------------------------------
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: softMint,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.035),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Profile picture
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: softMint,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.12),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      size: 52,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Meera Crafts',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.location_on_outlined,
                        size: 17,
                        color: secondaryText,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Rajasthan, India',
                        style: TextStyle(
                          fontSize: 14,
                          color: secondaryText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // Stats
                  Row(
                    children: const [
                      _Stat(
                        value: '4.8',
                        label: 'Rating',
                        icon: Icons.star_rounded,
                      ),
                      _Stat(
                        value: '28',
                        label: 'Products',
                        icon: Icons.inventory_2_outlined,
                      ),
                      _Stat(
                        value: '120+',
                        label: 'Sales',
                        icon: Icons.shopping_bag_outlined,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // ------------------------------------------------------------
            // ABOUT ARTISAN
            // ------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: lightMint,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: softMint,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        _SectionIcon(
                          icon: Icons.auto_awesome_outlined,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'About the Artisan',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: darkText,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 13),

                    const Text(
                      'Meera is a skilled traditional craftsperson '
                      'who creates beautiful handmade pottery using '
                      'traditional techniques passed down through '
                      'her family.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.65,
                        color: secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ------------------------------------------------------------
            // PRODUCTS TITLE
            // ------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Products by Meera',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: darkText,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: secondaryText,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ------------------------------------------------------------
            // PRODUCT GRID
            // ------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 13,
                  childAspectRatio: 0.76,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(19),
                      border: Border.all(
                        color: softMint,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.025),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product image area
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEAF4F1),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(19),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    width: 76,
                                    height: 76,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.75),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      product['icon'] as IconData,
                                      size: 40,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),

                                // Small product badge
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      borderRadius:
                                          BorderRadius.circular(20),
                                    ),
                                    child: const Icon(
                                      Icons.favorite_border_rounded,
                                      size: 17,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Product details
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            12,
                            11,
                            12,
                            13,
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'] as String,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.25,
                                  fontWeight: FontWeight.w700,
                                  color: darkText,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                product['price'] as String,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            // ------------------------------------------------------------
            // FOLLOW BUTTON
            // ------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'You are now following Meera Crafts',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.person_add_alt_1_rounded,
                    size: 21,
                  ),
                  label: const Text(
                    'Follow Artisan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
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
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}

// ==========================================================================
// SECTION ICON
// ==========================================================================

class _SectionIcon extends StatelessWidget {
  final IconData icon;

  const _SectionIcon({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.auto_awesome_outlined,
        size: 20,
        color: ArtisanProfileScreen.primaryColor,
      ),
    );
  }
}

// ==========================================================================
// STAT
// ==========================================================================

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _Stat({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: ArtisanProfileScreen.lightMint,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              size: 19,
              color: ArtisanProfileScreen.primaryColor,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: ArtisanProfileScreen.darkText,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: ArtisanProfileScreen.secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}