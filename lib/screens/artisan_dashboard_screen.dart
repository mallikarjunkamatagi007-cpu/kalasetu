import 'package:flutter/material.dart';

import 'add_product_screen.dart';
import 'ai_listing_screen.dart';
import 'my_products_screen.dart';
import 'artisan_orders_screen.dart';

class ArtisanDashboardScreen extends StatelessWidget {
  const ArtisanDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F0),
        elevation: 0,
        foregroundColor: const Color(0xFF5D2E0C),
        title: const Text(
          'Artisan Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notifications will be connected later.'),
                ),
              );
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------------------------------------------------
            // Welcome
            // ---------------------------------------------------------

            const Text(
              'Welcome, Meera! 👋',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D2E0C),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Manage your crafts and grow your business.',
              style: TextStyle(fontSize: 15, color: Color(0xFF795548)),
            ),

            const SizedBox(height: 25),

            // ---------------------------------------------------------
            // Sales Overview
            // ---------------------------------------------------------
            const Text(
              'Sales Overview',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D2E0C),
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    icon: Icons.currency_rupee,
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
                    icon: Icons.star_outline,
                    title: 'Rating',
                    value: '4.8',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ---------------------------------------------------------
            // AI Assistant
            // ---------------------------------------------------------
            const Text(
              'AI Assistant',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D2E0C),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF8B4513),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.white24,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),

                      const SizedBox(width: 15),

                      const Expanded(
                        child: Text(
                          'Create Product with AI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Upload a product photo and AI can suggest '
                    'a product name, description, category, tags '
                    'and price range.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      // -------------------------------------------------
                      // CREATE AI LISTING
                      // -------------------------------------------------
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddProductScreen(),
                          ),
                        );
                      },

                      icon: const Icon(Icons.add_a_photo_outlined),

                      label: const Text(
                        'Create AI Listing',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF8B4513),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ---------------------------------------------------------
            // Quick Actions
            // ---------------------------------------------------------
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D2E0C),
              ),
            ),

            const SizedBox(height: 15),

            // ---------------------------------------------------------
            // ADD NEW PRODUCT
            // ---------------------------------------------------------
            _actionCard(
              icon: Icons.add_box_outlined,
              title: 'Add New Product',
              subtitle: 'Create a new product listing',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProductScreen(),
                  ),
                );
              },
            ),

            // ---------------------------------------------------------
            // MY PRODUCTS
            // ---------------------------------------------------------
            _actionCard(
              icon: Icons.inventory_2_outlined,
              title: 'My Products',
              subtitle: 'View and manage your products',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyProductsScreen(),
                  ),
                );
              },
            ),

            // ---------------------------------------------------------
            // MANAGE ORDERS
            // ---------------------------------------------------------
            _actionCard(
              icon: Icons.local_shipping_outlined,
              title: 'Manage Orders',
              subtitle: 'View and update customer orders',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ArtisanOrdersScreen(),
                  ),
                );
              },
            ),

            // ---------------------------------------------------------
            // SALES & ANALYTICS
            // ---------------------------------------------------------
            _actionCard(
              icon: Icons.bar_chart_outlined,
              title: 'Sales & Analytics',
              subtitle: 'Track your marketplace performance',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sales & Analytics will be connected later.'),
                  ),
                );
              },
            ),

            const SizedBox(height: 25),

            // ---------------------------------------------------------
            // ARTISAN PROFILE
            // ---------------------------------------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE8D8C8)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5E6D3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      size: 32,
                      color: Color(0xFF8B4513),
                    ),
                  ),

                  const SizedBox(width: 15),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Meera Crafts',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5D2E0C),
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'Rajasthan, India',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF795548),
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Edit artisan profile will be connected later.',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: Color(0xFF8B4513),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // STAT CARD
  // ===============================================================

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8D8C8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF8B4513), size: 28),

          const SizedBox(height: 12),

          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D2E0C),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Color(0xFF795548)),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // ACTION CARD
  // ===============================================================

  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8D8C8)),
      ),
      child: ListTile(
        onTap: onTap,

        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),

        leading: Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Color(0xFFF5E6D3),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF8B4513)),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D2E0C),
          ),
        ),

        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Color(0xFF795548)),
        ),

        trailing: const Icon(Icons.chevron_right, color: Color(0xFF8B4513)),
      ),
    );
  }
}
