import 'dart:io';

import 'package:flutter/material.dart';

import 'add_product_screen.dart';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({super.key});

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  // ------------------------------------------------
  // DEMO PRODUCTS
  // ------------------------------------------------

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Handcrafted Clay Pot',
      'category': 'Pottery',
      'price': 650.0,
      'stock': 12,
      'sales': 24,
      'active': true,
      'image': null,
      'icon': Icons.local_florist_outlined,
    },
    {
      'name': 'Traditional Handwoven Bag',
      'category': 'Bags',
      'price': 899.0,
      'stock': 5,
      'sales': 18,
      'active': true,
      'image': null,
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'name': 'Wooden Decorative Plate',
      'category': 'Woodwork',
      'price': 750.0,
      'stock': 0,
      'sales': 31,
      'active': false,
      'image': null,
      'icon': Icons.circle_outlined,
    },
  ];

  // ------------------------------------------------
  // ADD PRODUCT
  // ------------------------------------------------

  Future<void> openAddProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddProductScreen()),
    );

    if (!mounted) {
      return;
    }

    if (result is Map<String, dynamic>) {
      setState(() {
        products.insert(0, result);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully!')),
      );
    }
  }

  // ------------------------------------------------
  // TOGGLE PRODUCT AVAILABILITY
  // ------------------------------------------------

  void toggleProduct(int index) {
    final bool currentStatus = products[index]['active'] == true;

    setState(() {
      products[index]['active'] = !currentStatus;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          currentStatus
              ? 'Product is now unavailable.'
              : 'Product is now available.',
        ),
      ),
    );
  }

  // ------------------------------------------------
  // DELETE PRODUCT
  // ------------------------------------------------

  void deleteProduct(int index) {
    final String productName = products[index]['name'].toString();

    setState(() {
      products.removeAt(index);
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$productName deleted.')));
  }

  // ------------------------------------------------
  // DELETE CONFIRMATION
  // ------------------------------------------------

  Future<void> confirmDelete(int index) async {
    final String productName = products[index]['name'].toString();

    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFF8F0),
          title: const Text(
            'Delete Product?',
            style: TextStyle(
              color: Color(0xFF5D2E0C),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to permanently delete "$productName"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF795548)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B4513),
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      deleteProduct(index);
    }
  }

  // ------------------------------------------------
  // EDIT PRODUCT
  // ------------------------------------------------

  void editProduct(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product editing will be connected next.')),
    );
  }

  // ------------------------------------------------
  // BUILD
  // ------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final int activeProducts = products
        .where((product) => product['active'] == true)
        .length;

    final int unavailableProducts = products
        .where((product) => product['active'] != true)
        .length;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E6),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF5E6),
        foregroundColor: const Color(0xFF5D2E0C),
        elevation: 0,

        title: const Text(
          'My Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        actions: [
          IconButton(
            onPressed: openAddProduct,
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Add Product',
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ------------------------------------------------
            // HEADER
            // ------------------------------------------------

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xFF8B4513),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                children: [
                  const Icon(
                    Icons.inventory_2_outlined,
                    color: Colors.white,
                    size: 35,
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Text(
                          'Manage Your Products',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          '${products.length} total products',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ------------------------------------------------
            // PRODUCT STATISTICS
            // ------------------------------------------------
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    Icons.check_circle_outline,
                    'Available',
                    activeProducts.toString(),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _statCard(
                    Icons.visibility_off_outlined,
                    'Unavailable',
                    unavailableProducts.toString(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ------------------------------------------------
            // TITLE
            // ------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                const Text(
                  'Your Products',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D2E0C),
                  ),
                ),

                TextButton.icon(
                  onPressed: openAddProduct,
                  icon: const Icon(Icons.add, color: Color(0xFF8B4513)),
                  label: const Text(
                    'Add New',
                    style: TextStyle(
                      color: Color(0xFF8B4513),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ------------------------------------------------
            // EMPTY STATE
            // ------------------------------------------------
            if (products.isEmpty)
              _emptyProducts()
            // ------------------------------------------------
            // PRODUCT LIST
            // ------------------------------------------------
            else
              ...List.generate(products.length, (index) {
                return _productCard(products[index], index);
              }),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------
  // STAT CARD
  // ------------------------------------------------

  Widget _statCard(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8D8C8)),
      ),

      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,

            decoration: const BoxDecoration(
              color: Color(0xFFF5E6D3),
              shape: BoxShape.circle,
            ),

            child: Icon(icon, color: const Color(0xFF8B4513)),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D2E0C),
                  ),
                ),

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF795548),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------
  // PRODUCT CARD
  // ------------------------------------------------

  Widget _productCard(Map<String, dynamic> product, int index) {
    final bool active = product['active'] == true;

    final int stock = (product['stock'] as num?)?.toInt() ?? 0;

    final int sales = (product['sales'] as num?)?.toInt() ?? 0;

    final double price = (product['price'] as num?)?.toDouble() ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8D8C8)),
      ),

      child: Padding(
        padding: const EdgeInsets.all(14),

        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // PRODUCT IMAGE
                Container(
                  width: 90,
                  height: 90,

                  decoration: BoxDecoration(
                    color: const Color(0xFFF5E6D3),
                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: _buildProductImage(product),
                ),

                const SizedBox(width: 14),

                // PRODUCT INFORMATION
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Expanded(
                            child: Text(
                              product['name'].toString(),

                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5D2E0C),
                              ),
                            ),
                          ),

                          PopupMenuButton<String>(
                            padding: EdgeInsets.zero,

                            icon: const Icon(
                              Icons.more_vert,
                              color: Color(0xFF795548),
                            ),

                            onSelected: (String value) {
                              if (value == 'edit') {
                                editProduct(index);
                              }

                              if (value == 'toggle') {
                                toggleProduct(index);
                              }

                              if (value == 'delete') {
                                confirmDelete(index);
                              }
                            },

                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit_outlined, size: 20),
                                      SizedBox(width: 10),
                                      Text('Edit'),
                                    ],
                                  ),
                                ),

                                PopupMenuItem(
                                  value: 'toggle',

                                  child: Row(
                                    children: [
                                      Icon(
                                        active
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        size: 20,
                                      ),

                                      const SizedBox(width: 10),

                                      Text(
                                        active
                                            ? 'Make Unavailable'
                                            : 'Make Available',
                                      ),
                                    ],
                                  ),
                                ),

                                const PopupMenuDivider(),

                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_outline, size: 20),
                                      SizedBox(width: 10),
                                      Text('Delete'),
                                    ],
                                  ),
                                ),
                              ];
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      Text(
                        product['category'].toString(),

                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF795548),
                        ),
                      ),

                      const SizedBox(height: 7),

                      Text(
                        '₹${price.toStringAsFixed(0)}',

                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B4513),
                        ),
                      ),

                      const SizedBox(height: 7),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),

                        decoration: BoxDecoration(
                          color: active
                              ? const Color(0xFFE8F5E9)
                              : const Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Text(
                          active ? 'Available' : 'Unavailable',

                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: active
                                ? Colors.green.shade700
                                : Colors.red.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            const Divider(color: Color(0xFFE8D8C8), height: 1),

            const SizedBox(height: 12),

            // STOCK AND SALES
            Row(
              children: [
                Expanded(
                  child: _productInfo(
                    Icons.inventory_2_outlined,
                    'Stock',
                    stock.toString(),
                  ),
                ),

                Container(width: 1, height: 30, color: const Color(0xFFE8D8C8)),

                Expanded(
                  child: _productInfo(
                    Icons.shopping_bag_outlined,
                    'Sales',
                    sales.toString(),
                  ),
                ),

                Container(width: 1, height: 30, color: const Color(0xFFE8D8C8)),

                Expanded(
                  child: _productInfo(
                    Icons.circle,
                    'Status',
                    active ? 'Live' : 'Hidden',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------
  // PRODUCT IMAGE
  // ------------------------------------------------

  Widget _buildProductImage(Map<String, dynamic> product) {
    final dynamic image = product['image'];

    if (image is File) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(14),

        child: Image.file(image, width: 90, height: 90, fit: BoxFit.cover),
      );
    }

    final IconData icon =
        product['icon'] as IconData? ?? Icons.inventory_2_outlined;

    return Center(child: Icon(icon, size: 42, color: const Color(0xFF8B4513)));
  }

  // ------------------------------------------------
  // PRODUCT INFO
  // ------------------------------------------------

  Widget _productInfo(IconData icon, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Icon(icon, size: 18, color: const Color(0xFF8B4513)),

        const SizedBox(width: 6),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D2E0C),
              ),
            ),

            Text(
              title,
              style: const TextStyle(fontSize: 10, color: Color(0xFF795548)),
            ),
          ],
        ),
      ],
    );
  }

  // ------------------------------------------------
  // EMPTY PRODUCTS
  // ------------------------------------------------

  Widget _emptyProducts() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(35),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8D8C8)),
      ),

      child: Column(
        children: [
          const Icon(
            Icons.inventory_2_outlined,
            size: 65,
            color: Color(0xFF8B4513),
          ),

          const SizedBox(height: 15),

          const Text(
            'No Products Yet',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D2E0C),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Add your first handmade product to start selling.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Color(0xFF795548)),
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: openAddProduct,

            icon: const Icon(Icons.add),

            label: const Text('Add Product'),

            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B4513),
              foregroundColor: Colors.white,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
