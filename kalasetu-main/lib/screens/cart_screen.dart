import 'package:flutter/material.dart';

import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // ================================================================
  // COLORS
  // ================================================================

  static const Color backgroundColor = Color(0xFFE8F3EF);
  static const Color cardColor = Color(0xFFF9FCFA);
  static const Color primaryColor = Color(0xFF126B68);
  static const Color darkText = Color(0xFF193B39);
  static const Color secondaryText = Color(0xFF6B7D7A);
  static const Color softMint = Color(0xFFD9EAE5);
  static const Color lightMint = Color(0xFFF0F7F4);

  // ================================================================
  // CART DATA
  // ================================================================

  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Handmade Clay Pot',
      'artisan': 'Meera Crafts',
      'price': 450,
      'quantity': 1,
      'icon': Icons.local_florist_outlined,
    },
    {
      'name': 'Handcrafted Necklace',
      'artisan': 'Asha Jewellery',
      'price': 950,
      'quantity': 1,
      'icon': Icons.diamond_outlined,
    },
  ];

  // ================================================================
  // PRICE CALCULATIONS
  // ================================================================

  double get subtotal {
    double total = 0;

    for (final item in cartItems) {
      total += item['price'] * item['quantity'];
    }

    return total;
  }

  double get deliveryFee {
    return subtotal >= 1000 ? 0 : 80;
  }

  double get total {
    return subtotal + deliveryFee;
  }

  // ================================================================
  // QUANTITY
  // ================================================================

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      }
    });
  }

  // ================================================================
  // REMOVE ITEM
  // ================================================================

  void removeItem(int index) {
    final name = cartItems[index]['name'];

    setState(() {
      cartItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name removed from cart'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // ================================================================
  // BUILD
  // ================================================================

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
          'My Cart',
          style: TextStyle(
            color: darkText,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          if (cartItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: softMint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${cartItems.length} items',
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),

      // ------------------------------------------------------------
      // BODY
      // ------------------------------------------------------------

      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      8,
                      20,
                      15,
                    ),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];

                      return _buildCartItem(
                        item,
                        index,
                      );
                    },
                  ),
                ),

                _buildOrderSummary(),
              ],
            ),
    );
  }

  // ================================================================
  // CART ITEM
  // ================================================================

  Widget _buildCartItem(
    Map<String, dynamic> item,
    int index,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFD6E5E0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 11,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----------------------------------------------------------
          // PRODUCT IMAGE
          // ----------------------------------------------------------

          Container(
            width: 88,
            height: 96,
            decoration: BoxDecoration(
              color: lightMint,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 57,
                  height: 57,
                  decoration: const BoxDecoration(
                    color: softMint,
                    shape: BoxShape.circle,
                  ),
                ),
                Icon(
                  item['icon'] as IconData,
                  size: 32,
                  color: primaryColor,
                ),
              ],
            ),
          ),

          const SizedBox(width: 13),

          // ----------------------------------------------------------
          // DETAILS
          // ----------------------------------------------------------

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product name + delete
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item['name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: darkText,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                    ),

                    const SizedBox(width: 5),

                    GestureDetector(
                      onTap: () => removeItem(index),
                      child: Container(
                        width: 31,
                        height: 31,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF1F1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.redAccent,
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                // Artisan
                Text(
                  item['artisan'],
                  style: const TextStyle(
                    color: secondaryText,
                    fontSize: 10.5,
                  ),
                ),

                const SizedBox(height: 8),

                // Price
                Text(
                  '₹${item['price']}',
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 9),

                // Quantity controls
                Row(
                  children: [
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: lightMint,
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: const Color(0xFFD6E5E0),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _quantityButton(
                            icon: Icons.remove_rounded,
                            onTap: () {
                              decreaseQuantity(index);
                            },
                          ),

                          SizedBox(
                            width: 30,
                            child: Center(
                              child: Text(
                                '${item['quantity']}',
                                style: const TextStyle(
                                  color: darkText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),

                          _quantityButton(
                            icon: Icons.add_rounded,
                            onTap: () {
                              increaseQuantity(index);
                            },
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Item total
                    Text(
                      '₹${item['price'] * item['quantity']}',
                      style: const TextStyle(
                        color: darkText,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // QUANTITY BUTTON
  // ================================================================

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: SizedBox(
        width: 30,
        height: 33,
        child: Icon(
          icon,
          color: primaryColor,
          size: 16,
        ),
      ),
    );
  }

  // ================================================================
  // ORDER SUMMARY
  // ================================================================

  Widget _buildOrderSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        20,
        18,
        20,
        22,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
        border: const Border(
          top: BorderSide(
            color: Color(0xFFD6E5E0),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.045),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Summary heading
          const Row(
            children: [
              Icon(
                Icons.receipt_long_outlined,
                color: primaryColor,
                size: 19,
              ),
              SizedBox(width: 8),
              Text(
                'Order Summary',
                style: TextStyle(
                  color: darkText,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          _priceRow(
            'Subtotal',
            '₹${subtotal.toStringAsFixed(0)}',
          ),

          const SizedBox(height: 9),

          _priceRow(
            'Delivery',
            deliveryFee == 0
                ? 'FREE'
                : '₹${deliveryFee.toStringAsFixed(0)}',
            isDelivery: true,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 13),
            child: Divider(
              color: Color(0xFFDDE9E5),
              height: 1,
            ),
          ),

          _priceRow(
            'Total',
            '₹${total.toStringAsFixed(0)}',
            isTotal: true,
          ),

          const SizedBox(height: 16),

          // ----------------------------------------------------------
          // CHECKOUT BUTTON
          // ----------------------------------------------------------

          SizedBox(
            width: double.infinity,
            height: 53,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(
                      total: total,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Proceed to Checkout',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 9),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 19,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // PRICE ROW
  // ================================================================

  Widget _priceRow(
    String title,
    String value, {
    bool isTotal = false,
    bool isDelivery = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 16 : 12.5,
            fontWeight:
                isTotal ? FontWeight.w800 : FontWeight.w500,
            color: isTotal ? darkText : secondaryText,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 17 : 13,
            fontWeight: FontWeight.w800,
            color: isDelivery && deliveryFee == 0
                ? primaryColor
                : isTotal
                    ? primaryColor
                    : darkText,
          ),
        ),
      ],
    );
  }

  // ================================================================
  // EMPTY CART
  // ================================================================

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: softMint,
                borderRadius: BorderRadius.circular(29),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 47,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Your cart is empty',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: darkText,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 9),

            const Text(
              'Discover beautiful handmade products '
              'from talented artisans.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: secondaryText,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 49,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 23,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_rounded,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Continue Shopping',
                      style: TextStyle(
                        fontSize: 13,
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
    );
  }
}