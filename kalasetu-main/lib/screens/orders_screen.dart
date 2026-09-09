import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const Color backgroundColor = Color(0xFFE8F3EF);
  static const Color cardColor = Color(0xFFF9FCFA);
  static const Color primaryColor = Color(0xFF126B68);
  static const Color darkText = Color(0xFF193B39);
  static const Color secondaryText = Color(0xFF6B7D7A);
  static const Color softMint = Color(0xFFD9EAE5);
  static const Color successColor = Color(0xFF3F8F72);
  static const Color warningColor = Color(0xFFB27A32);

  static const List<Map<String, dynamic>> orders = [
    {
      'id': 'ORD-1001',
      'product': 'Handmade Clay Pot',
      'artisan': 'Meera Crafts',
      'price': 450.0,
      'quantity': 1,
      'status': 'Delivered',
      'date': '05 Sep 2026',
      'icon': Icons.local_florist_outlined,
    },
    {
      'id': 'ORD-1002',
      'product': 'Handcrafted Necklace',
      'artisan': 'Asha Jewellery',
      'price': 950.0,
      'quantity': 1,
      'status': 'Shipped',
      'date': '07 Sep 2026',
      'icon': Icons.diamond_outlined,
    },
    {
      'id': 'ORD-1003',
      'product': 'Traditional Saree',
      'artisan': 'Sita Handlooms',
      'price': 1800.0,
      'quantity': 1,
      'status': 'Processing',
      'date': '08 Sep 2026',
      'icon': Icons.checkroom_outlined,
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
        titleSpacing: 20,
        title: const Text(
          'My Orders',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: darkText,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 18),
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: softMint,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${orders.length} Orders',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: orders.isEmpty
          ? _buildEmptyOrders()
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 25),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return _buildOrderCard(
                  context,
                  order,
                );
              },
            ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context,
    Map<String, dynamic> order,
  ) {
    final bool isDelivered = order['status'] == 'Delivered';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFDCE9E5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // -------------------------------------------------------------
            // Order Header
            // -------------------------------------------------------------
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: softMint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    order['id'],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: primaryColor,
                    ),
                  ),
                ),
                const Spacer(),
                _buildStatusBadge(order['status']),
              ],
            ),

            const SizedBox(height: 16),

            // -------------------------------------------------------------
            // Product Information
            // -------------------------------------------------------------
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF4F1),
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                      color: const Color(0xFFDCEAE5),
                    ),
                  ),
                  child: Icon(
                    order['icon'],
                    size: 40,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['product'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.25,
                          fontWeight: FontWeight.w800,
                          color: darkText,
                        ),
                      ),

                      const SizedBox(height: 7),

                      Row(
                        children: [
                          const Icon(
                            Icons.storefront_outlined,
                            size: 15,
                            color: secondaryText,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              order['artisan'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: secondaryText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(
                        '₹${order['price'].toStringAsFixed(0)} × ${order['quantity']}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Divider
            Container(
              height: 1,
              color: const Color(0xFFE4EEEB),
            ),

            const SizedBox(height: 14),

            // -------------------------------------------------------------
            // Order Date
            // -------------------------------------------------------------
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: secondaryText,
                ),
                const SizedBox(width: 7),
                const Text(
                  'Order Date',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  order['date'],
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // -------------------------------------------------------------
            // Track / View Button
            // -------------------------------------------------------------
            SizedBox(
              width: double.infinity,
              height: 46,
              child: OutlinedButton(
                onPressed: () {
                  _showOrderDetails(
                    context,
                    order,
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryColor,
                  side: const BorderSide(
                    color: primaryColor,
                    width: 1.2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isDelivered
                          ? Icons.visibility_outlined
                          : Icons.local_shipping_outlined,
                      size: 19,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isDelivered ? 'View Order' : 'Track Order',
                      style: const TextStyle(
                        fontSize: 13.5,
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

  // -----------------------------------------------------------------------
  // Status Badge
  // -----------------------------------------------------------------------

  Widget _buildStatusBadge(String status) {
    IconData icon;
    Color color;
    Color background;

    if (status == 'Delivered') {
      icon = Icons.check_circle_outline_rounded;
      color = successColor;
      background = const Color(0xFFE5F3ED);
    } else if (status == 'Shipped') {
      icon = Icons.local_shipping_outlined;
      color = primaryColor;
      background = const Color(0xFFE5F2F1);
    } else {
      icon = Icons.inventory_2_outlined;
      color = warningColor;
      background = const Color(0xFFF8F0E2);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            status,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Order Tracking Bottom Sheet
  // -----------------------------------------------------------------------

  void _showOrderDetails(
    BuildContext context,
    Map<String, dynamic> order,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(
            22,
            12,
            22,
            25,
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD5E2DE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // Header
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: softMint,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.local_shipping_outlined,
                        color: primaryColor,
                        size: 23,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Tracking',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: darkText,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Track the progress of your order',
                            style: TextStyle(
                              fontSize: 12,
                              color: secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Order ID
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F7F4),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Order ID',
                        style: TextStyle(
                          fontSize: 12,
                          color: secondaryText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        order['id'],
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                _trackingStep(
                  'Order Placed',
                  true,
                  Icons.receipt_long_outlined,
                  isLast: false,
                ),

                _trackingStep(
                  'Order Processing',
                  order['status'] != 'Pending',
                  Icons.inventory_2_outlined,
                  isLast: false,
                ),

                _trackingStep(
                  'Shipped',
                  order['status'] == 'Shipped' ||
                      order['status'] == 'Delivered',
                  Icons.local_shipping_outlined,
                  isLast: false,
                ),

                _trackingStep(
                  'Delivered',
                  order['status'] == 'Delivered',
                  Icons.check_circle_outline_rounded,
                  isLast: true,
                ),

                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }

  // -----------------------------------------------------------------------
  // Tracking Step
  // -----------------------------------------------------------------------

  Widget _trackingStep(
    String title,
    bool completed,
    IconData icon, {
    required bool isLast,
  }) {
    return SizedBox(
      height: 62,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 42,
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: completed
                        ? primaryColor
                        : const Color(0xFFE5EEEB),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: completed
                        ? Colors.white
                        : const Color(0xFF9BA9A6),
                    size: 19,
                  ),
                ),

                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: completed
                          ? const Color(0xFFB8D8D0)
                          : const Color(0xFFE1E9E6),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight:
                    completed ? FontWeight.w800 : FontWeight.w500,
                color: completed
                    ? darkText
                    : const Color(0xFF9BA9A6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Empty Orders
  // -----------------------------------------------------------------------

  Widget _buildEmptyOrders() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: softMint,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 48,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'No Orders Yet',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),

            const SizedBox(height: 9),

            const Text(
              'Your purchases will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: secondaryText,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}