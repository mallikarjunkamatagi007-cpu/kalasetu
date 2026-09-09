import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const Color backgroundColor = Color(0xFFE8F3EF);
  static const Color cardColor = Color(0xFFF9FCFA);
  static const Color primaryColor = Color(0xFF126B68);
  static const Color darkText = Color(0xFF193B39);
  static const Color secondaryText = Color(0xFF6B7D7A);
  static const Color softMint = Color(0xFFD9EAE5);
  static const Color lightMint = Color(0xFFF0F7F4);

  static const List<Map<String, dynamic>> categories = [
    {
      'name': 'Handicrafts',
      'icon': Icons.handyman_outlined,
      'description': 'Unique handmade crafts',
    },
    {
      'name': 'Textiles',
      'icon': Icons.checkroom_outlined,
      'description': 'Traditional fabrics and clothing',
    },
    {
      'name': 'Jewellery',
      'icon': Icons.diamond_outlined,
      'description': 'Handcrafted jewellery',
    },
    {
      'name': 'Pottery',
      'icon': Icons.circle_outlined,
      'description': 'Clay and ceramic products',
    },
    {
      'name': 'Woodwork',
      'icon': Icons.carpenter_outlined,
      'description': 'Beautiful wooden crafts',
    },
    {
      'name': 'Paintings',
      'icon': Icons.palette_outlined,
      'description': 'Traditional and modern art',
    },
    {
      'name': 'Home Decor',
      'icon': Icons.home_outlined,
      'description': 'Handmade decoration',
    },
    {
      'name': 'Bags',
      'icon': Icons.shopping_bag_outlined,
      'description': 'Handmade bags and accessories',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // ------------------------------------------------------------
      // APP BAR
      // ------------------------------------------------------------
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: darkText,
        titleSpacing: 20,
        title: const Text(
          'Categories',
          style: TextStyle(
            color: darkText,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      // ------------------------------------------------------------
      // BODY
      // ------------------------------------------------------------
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ------------------------------------------------------
              // HEADER
              // ------------------------------------------------------
              const Text(
                'Explore Categories',
                style: TextStyle(
                  color: darkText,
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Find beautiful products made by talented artisans.',
                style: TextStyle(
                  color: secondaryText,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 22),

              // ------------------------------------------------------
              // CATEGORY COUNT
              // ------------------------------------------------------
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: softMint,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.grid_view_rounded,
                          color: primaryColor,
                          size: 15,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '8 Categories',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // ------------------------------------------------------
              // CATEGORY GRID
              // ------------------------------------------------------
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 13,
                    mainAxisSpacing: 13,
                    childAspectRatio: 0.95,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];

                    return _categoryCard(
                      context,
                      category,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================================================================
  // CATEGORY CARD
  // ================================================================

  Widget _categoryCard(
    BuildContext context,
    Map<String, dynamic> category,
  ) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${category['name']} selected',
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFD6E5E0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // --------------------------------------------------------
            // ICON
            // --------------------------------------------------------
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: softMint,
                borderRadius: BorderRadius.circular(19),
              ),
              child: Icon(
                category['icon'] as IconData,
                size: 30,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 13),

            // --------------------------------------------------------
            // CATEGORY NAME
            // --------------------------------------------------------
            Text(
              category['name'],
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: darkText,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 6),

            // --------------------------------------------------------
            // DESCRIPTION
            // --------------------------------------------------------
            Text(
              category['description'],
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: secondaryText,
                fontSize: 10.5,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 9),

            // --------------------------------------------------------
            // SMALL ARROW
            // --------------------------------------------------------
            Container(
              width: 27,
              height: 27,
              decoration: BoxDecoration(
                color: lightMint,
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: primaryColor,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}