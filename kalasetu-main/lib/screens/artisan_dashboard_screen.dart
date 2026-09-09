import 'package:flutter/material.dart';

import 'add_product_screen.dart';
import 'my_products_screen.dart';
import 'artisan_orders_screen.dart';

class ArtisanDashboardScreen extends StatelessWidget {
  const ArtisanDashboardScreen({super.key});

  // -----------------------------------------------------------------------
  // KalaSetu Theme
  // -----------------------------------------------------------------------

  static const Color backgroundColor = Color(0xFFE8F3EF);
  static const Color cardColor = Color(0xFFF9FCFA);
  static const Color primaryColor = Color(0xFF126B68);
  static const Color darkText = Color(0xFF193B39);
  static const Color secondaryText = Color(0xFF6B7D7A);
  static const Color softMint = Color(0xFFD9EAE5);
  static const Color lightMint = Color(0xFFF0F7F4);

  @override
  Widget build(BuildContext context) {
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
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Artisan Dashboard',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Manage your KalaSetu store',
              style: TextStyle(
                fontSize: 10.5,
                color: secondaryText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Notifications will be connected later.',
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications_none_rounded,
                size: 21,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),

      // -------------------------------------------------------------------
      // Body
      // -------------------------------------------------------------------

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          18,
          8,
          18,
          30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------------------------------------------------------
            // Welcome Section
            // ---------------------------------------------------------------

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(21),
                border: Border.all(
                  color: const Color(0xFFDCE9E5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.025),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 53,
                    height: 53,
                    decoration: const BoxDecoration(
                      color: softMint,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: primaryColor,
                      size: 27,
                    ),
                  ),

                  const SizedBox(width: 13),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, Meera! 👋',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: darkText,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Manage your crafts and grow your business.',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.35,
                            color: secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 27),

            // ---------------------------------------------------------------
            // Sales Overview
            // ---------------------------------------------------------------

            const Text(
              'Sales Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'A quick look at your store performance',
              style: TextStyle(
                fontSize: 12,
                color: secondaryText,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    icon: Icons.currency_rupee_rounded,
                    title: 'Total Sales',
                    value: '₹24,500',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    icon: Icons.shopping_bag_outlined,
                    title: 'Orders',
                    value: '32',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    icon: Icons.inventory_2_outlined,
                    title: 'Products',
                    value: '18',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    icon: Icons.star_outline_rounded,
                    title: 'Rating',
                    value: '4.8',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 29),

            // ---------------------------------------------------------------
            // AI Assistant
            // ---------------------------------------------------------------

            const Text(
              'AI Assistant',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),

            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(19),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF126B68),
                    Color(0xFF1A7773),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.15),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 49,
                        height: 49,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.16),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),

                      const SizedBox(width: 13),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create Product with AI',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Create listings faster',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Upload a product photo and AI can suggest a '
                    'product name, description, category, tags '
                    'and price range.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.5,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 17),

                  SizedBox(
                    width: double.infinity,
                    height: 47,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AddProductScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add_a_photo_outlined,
                        size: 19,
                      ),
                      label: const Text(
                        'Create AI Listing',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 29),

            // ---------------------------------------------------------------
            // Quick Actions
            // ---------------------------------------------------------------

            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Manage your store from one place',
              style: TextStyle(
                fontSize: 12,
                color: secondaryText,
              ),
            ),

            const SizedBox(height: 14),

            // Add Product
            _actionCard(
              icon: Icons.add_box_outlined,
              title: 'Add New Product',
              subtitle: 'Create a new product listing',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const AddProductScreen(),
                  ),
                );
              },
            ),

            // My Products
            _actionCard(
              icon: Icons.inventory_2_outlined,
              title: 'My Products',
              subtitle: 'View and manage your products',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MyProductsScreen(),
                  ),
                );
              },
            ),

            // Manage Orders
            _actionCard(
              icon: Icons.local_shipping_outlined,
              title: 'Manage Orders',
              subtitle: 'View and update customer orders',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ArtisanOrdersScreen(),
                  ),
                );
              },
            ),

            // Sales & Analytics
            _actionCard(
              icon: Icons.bar_chart_rounded,
              title: 'Sales & Analytics',
              subtitle: 'Track your marketplace performance',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Sales & Analytics will be connected later.',
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 14),

            // ---------------------------------------------------------------
            // Artisan Profile
            // ---------------------------------------------------------------

            const Text(
              'Your Artisan Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),

            const SizedBox(height: 13),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
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
              child: Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: const BoxDecoration(
                      color: softMint,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      size: 30,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(width: 13),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Meera Crafts',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: darkText,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: secondaryText,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Rajasthan, India',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 39,
                    height: 39,
                    decoration: BoxDecoration(
                      color: lightMint,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Edit artisan profile will be connected later.',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: primaryColor,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Stat Card
  // -----------------------------------------------------------------------

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFDCE9E5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 13,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: softMint,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 22,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: secondaryText,
                    fontWeight: FontWeight.w500,
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
  // Action Card
  // -----------------------------------------------------------------------

  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFDCE9E5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(17),
        child: InkWell(
          borderRadius: BorderRadius.circular(17),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            child: Row(
              children: [
                Container(
                  width: 47,
                  height: 47,
                  decoration: BoxDecoration(
                    color: softMint,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: primaryColor,
                    size: 22,
                  ),
                ),

                const SizedBox(width: 13),

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
                        subtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          color: secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 31,
                  height: 31,
                  decoration: BoxDecoration(
                    color: lightMint,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 17,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}