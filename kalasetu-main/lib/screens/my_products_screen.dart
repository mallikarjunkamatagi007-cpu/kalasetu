import 'dart:io';

import 'package:flutter/material.dart';

import 'add_product_screen.dart';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({super.key});

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
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
  // DEMO PRODUCTS
  // --------------------------------------------------------------------------

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

  // --------------------------------------------------------------------------
  // ADD PRODUCT
  // --------------------------------------------------------------------------

  Future<void> openAddProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddProductScreen(),
      ),
    );

    if (!mounted) {
      return;
    }

    if (result is Map<String, dynamic>) {
      setState(() {
        products.insert(0, result);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added successfully!'),
        ),
      );
    }
  }

  // --------------------------------------------------------------------------
  // TOGGLE PRODUCT AVAILABILITY
  // --------------------------------------------------------------------------

  void toggleProduct(int index) {
    final bool currentStatus =
        products[index]['active'] == true;

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

  // --------------------------------------------------------------------------
  // DELETE PRODUCT
  // --------------------------------------------------------------------------

  void deleteProduct(int index) {
    final String productName =
        products[index]['name'].toString();

    setState(() {
      products.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$productName deleted.'),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // DELETE CONFIRMATION
  // --------------------------------------------------------------------------

  Future<void> confirmDelete(int index) async {
    final String productName =
        products[index]['name'].toString();

    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Delete Product?',
            style: TextStyle(
              color: darkText,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            'Are you sure you want to permanently delete "$productName"?',
            style: const TextStyle(
              color: secondaryText,
              height: 1.45,
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(
            18,
            0,
            18,
            14,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: secondaryText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Delete',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      deleteProduct(index);
    }
  }

  // --------------------------------------------------------------------------
  // EDIT PRODUCT
  // --------------------------------------------------------------------------

  void editProduct(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Product editing will be connected next.',
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // BUILD
  // --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final int activeProducts = products
        .where((product) => product['active'] == true)
        .length;

    final int unavailableProducts = products
        .where((product) => product['active'] != true)
        .length;

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: darkText,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'My Products',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: darkText,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: openAddProduct,
              tooltip: 'Add Product',
              icon: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          18,
          8,
          18,
          35,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------------------------------------------
            // HEADER
            // ----------------------------------------------------------------

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(21),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.14),
                    blurRadius: 18,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.inventory_2_outlined,
                      color: Colors.white,
                      size: 29,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Manage Your Products',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
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

            const SizedBox(height: 18),

            // ----------------------------------------------------------------
            // STATISTICS
            // ----------------------------------------------------------------

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    Icons.check_circle_outline_rounded,
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

            const SizedBox(height: 27),

            // ----------------------------------------------------------------
            // TITLE
            // ----------------------------------------------------------------

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Products',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: darkText,
                  ),
                ),

                TextButton.icon(
                  onPressed: openAddProduct,
                  icon: const Icon(
                    Icons.add_rounded,
                    color: primaryColor,
                    size: 19,
                  ),
                  label: const Text(
                    'Add New',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 9),

            // ----------------------------------------------------------------
            // EMPTY STATE / PRODUCT LIST
            // ----------------------------------------------------------------

            if (products.isEmpty)
              _emptyProducts()
            else
              ...List.generate(
                products.length,
                (index) {
                  return _productCard(
                    products[index],
                    index,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // STAT CARD
  // --------------------------------------------------------------------------

  Widget _statCard(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
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
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: lightMint,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 21,
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
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // PRODUCT CARD
  // --------------------------------------------------------------------------

  Widget _productCard(
    Map<String, dynamic> product,
    int index,
  ) {
    final bool active =
        product['active'] == true;

    final int stock =
        (product['stock'] as num?)?.toInt() ?? 0;

    final int sales =
        (product['sales'] as num?)?.toInt() ?? 0;

    final double price =
        (product['price'] as num?)?.toDouble() ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: softMint,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 13,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            // --------------------------------------------------------------
            // MAIN PRODUCT ROW
            // --------------------------------------------------------------

            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // PRODUCT IMAGE
                Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    color: lightMint,
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: _buildProductImage(product),
                ),

                const SizedBox(width: 13),

                // PRODUCT INFORMATION
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              product['name']
                                  .toString(),
                              maxLines: 2,
                              overflow:
                                  TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                height: 1.25,
                                fontWeight:
                                    FontWeight.w800,
                                color: darkText,
                              ),
                            ),
                          ),

                          PopupMenuButton<String>(
                            padding: EdgeInsets.zero,
                            constraints:
                                const BoxConstraints(
                              minWidth: 42,
                              minHeight: 42,
                            ),
                            icon: const Icon(
                              Icons.more_vert_rounded,
                              color: secondaryText,
                              size: 21,
                            ),
                            onSelected:
                                (String value) {
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
                                      Icon(
                                        Icons.edit_outlined,
                                        size: 19,
                                      ),
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
                                            ? Icons
                                                .visibility_off_outlined
                                            : Icons
                                                .visibility_outlined,
                                        size: 19,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
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
                                      Icon(
                                        Icons
                                            .delete_outline_rounded,
                                        size: 19,
                                      ),
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
                          color: secondaryText,
                        ),
                      ),

                      const SizedBox(height: 7),

                      Text(
                        '₹${price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: primaryColor,
                        ),
                      ),

                      const SizedBox(height: 7),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: active
                              ? const Color(0xFFE4F2EE)
                              : const Color(0xFFF1E8E7),
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: Text(
                          active
                              ? 'Available'
                              : 'Unavailable',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                                FontWeight.w700,
                            color: active
                                ? primaryColor
                                : const Color(
                                    0xFF8B5550,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Divider(
              color: softMint,
              height: 1,
            ),

            const SizedBox(height: 12),

            // --------------------------------------------------------------
            // STOCK / SALES / STATUS
            // --------------------------------------------------------------

            Row(
              children: [
                Expanded(
                  child: _productInfo(
                    Icons.inventory_2_outlined,
                    'Stock',
                    stock.toString(),
                  ),
                ),

                Container(
                  width: 1,
                  height: 30,
                  color: softMint,
                ),

                Expanded(
                  child: _productInfo(
                    Icons.shopping_bag_outlined,
                    'Sales',
                    sales.toString(),
                  ),
                ),

                Container(
                  width: 1,
                  height: 30,
                  color: softMint,
                ),

                Expanded(
                  child: _productInfo(
                    active
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
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

  // --------------------------------------------------------------------------
  // PRODUCT IMAGE
  // --------------------------------------------------------------------------

  Widget _buildProductImage(
    Map<String, dynamic> product,
  ) {
    final dynamic image = product['image'];

    if (image is File) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(
          image,
          width: 92,
          height: 92,
          fit: BoxFit.cover,
        ),
      );
    }

    final IconData icon =
        product['icon'] as IconData? ??
            Icons.inventory_2_outlined;

    return Center(
      child: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 31,
          color: primaryColor,
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // PRODUCT INFO
  // --------------------------------------------------------------------------

  Widget _productInfo(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 17,
          color: primaryColor,
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                color: secondaryText,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // EMPTY PRODUCTS
  // --------------------------------------------------------------------------

  Widget _emptyProducts() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        28,
        35,
        28,
        32,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: softMint,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              color: lightMint,
              borderRadius:
                  BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              size: 38,
              color: primaryColor,
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'No Products Yet',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: darkText,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Add your first handmade product to start selling.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.45,
              color: secondaryText,
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: openAddProduct,
            icon: const Icon(
              Icons.add_rounded,
              size: 20,
            ),
            label: const Text(
              'Add Product',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 13,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}