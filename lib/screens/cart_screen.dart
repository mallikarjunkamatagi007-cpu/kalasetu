import 'package:flutter/material.dart';

import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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

  void removeItem(int index) {
    final name = cartItems[index]['name'];

    setState(() {
      cartItems.removeAt(index);
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$name removed from cart')));
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
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE8D8C8)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 85,
                              height: 95,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5E6D3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                item['icon'],
                                size: 45,
                                color: const Color(0xFF8B4513),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF5D2E0C),
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    item['artisan'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF795548),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    '₹${item['price']}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF8B4513),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF5E6D3),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                decreaseQuantity(index);
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                size: 18,
                                              ),
                                            ),
                                            Text(
                                              '${item['quantity']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                increaseQuantity(index);
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                size: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const Spacer(),

                                      IconButton(
                                        onPressed: () {
                                          removeItem(index);
                                        },
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
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
                    },
                  ),
                ),

                _buildOrderSummary(),
              ],
            ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          _priceRow('Subtotal', '₹${subtotal.toStringAsFixed(0)}'),

          const SizedBox(height: 10),

          _priceRow(
            'Delivery',
            deliveryFee == 0 ? 'FREE' : '₹${deliveryFee.toStringAsFixed(0)}',
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Divider(),
          ),

          _priceRow('Total', '₹${total.toStringAsFixed(0)}', isTotal: true),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(total: total),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B4513),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Proceed to Checkout',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 19 : 15,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: const Color(0xFF5D2E0C),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 19 : 15,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF8B4513),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 90,
              color: Color(0xFFBCAAA4),
            ),

            const SizedBox(height: 20),

            const Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D2E0C),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Discover beautiful handmade products '
              'from talented artisans.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF795548)),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B4513),
                foregroundColor: Colors.white,
              ),
              child: const Text('Continue Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
