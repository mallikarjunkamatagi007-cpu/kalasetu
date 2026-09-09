import 'package:flutter/material.dart';

class ArtisanOrdersScreen extends StatefulWidget {
  const ArtisanOrdersScreen({super.key});

  @override
  State<ArtisanOrdersScreen> createState() =>
      _ArtisanOrdersScreenState();
}

class _ArtisanOrdersScreenState
    extends State<ArtisanOrdersScreen> {
  final List<Map<String, dynamic>> orders = [
    {
      'id': 'ORD-1003',
      'customer': 'Rahul Sharma',
      'product': 'Traditional Clay Pot',
      'quantity': 2,
      'price': 900.0,
      'date': '08 Sep 2026',
      'status': 'New',
      'icon': Icons.local_florist_outlined,
    },
    {
      'id': 'ORD-1004',
      'customer': 'Priya Singh',
      'product': 'Decorative Terracotta Vase',
      'quantity': 1,
      'price': 850.0,
      'date': '07 Sep 2026',
      'status': 'Preparing',
      'icon': Icons.spa_outlined,
    },
    {
      'id': 'ORD-1005',
      'customer': 'Amit Patel',
      'product': 'Handmade Clay Diya Set',
      'quantity': 3,
      'price': 900.0,
      'date': '06 Sep 2026',
      'status': 'Shipped',
      'icon': Icons.light_mode_outlined,
    },
    {
      'id': 'ORD-1006',
      'customer': 'Neha Verma',
      'product': 'Painted Clay Pot',
      'quantity': 1,
      'price': 650.0,
      'date': '04 Sep 2026',
      'status': 'Delivered',
      'icon': Icons.palette_outlined,
    },
  ];

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

  // -----------------------------------------------------------------------
  // Update Order Status
  // -----------------------------------------------------------------------

  void updateStatus(int index) {
    final currentStatus = orders[index]['status'];

    String nextStatus;

    if (currentStatus == 'New') {
      nextStatus = 'Preparing';
    } else if (currentStatus == 'Preparing') {
      nextStatus = 'Shipped';
    } else if (currentStatus == 'Shipped') {
      nextStatus = 'Delivered';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'This order has already been delivered.',
          ),
        ),
      );
      return;
    }

    setState(() {
      orders[index]['status'] = nextStatus;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Order ${orders[index]['id']} updated to $nextStatus.',
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Status Color
  // -----------------------------------------------------------------------

  Color statusColor(String status) {
    if (status == 'Delivered') {
      return const Color(0xFF3F9D67);
    }

    if (status == 'Shipped') {
      return const Color(0xFF3478B9);
    }

    if (status == 'Preparing') {
      return const Color(0xFFD99128);
    }

    return primaryColor;
  }

  // -----------------------------------------------------------------------
  // Status Icon
  // -----------------------------------------------------------------------

  IconData statusIcon(String status) {
    if (status == 'Delivered') {
      return Icons.check_circle_outline_rounded;
    }

    if (status == 'Shipped') {
      return Icons.local_shipping_outlined;
    }

    if (status == 'Preparing') {
      return Icons.inventory_2_outlined;
    }

    return Icons.notifications_active_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final newOrders =
        orders.where((order) => order['status'] == 'New').length;

    final preparingOrders = orders
        .where((order) => order['status'] == 'Preparing')
        .length;

    final shippedOrders = orders
        .where((order) => order['status'] == 'Shipped')
        .length;

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
              'Customer Orders',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Manage and update your orders',
              style: TextStyle(
                fontSize: 10.5,
                color: secondaryText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),

      // -------------------------------------------------------------------
      // Body
      // -------------------------------------------------------------------

      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          18,
          8,
          18,
          30,
        ),
        children: [
          // ---------------------------------------------------------------
          // Header
          // ---------------------------------------------------------------

          const Text(
            'Manage Orders',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w800,
              color: darkText,
              letterSpacing: -0.4,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Manage customer orders and update their status.',
            style: TextStyle(
              fontSize: 13,
              color: secondaryText,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 23),

          // ---------------------------------------------------------------
          // Order Statistics
          // ---------------------------------------------------------------

          Row(
            children: [
              Expanded(
                child: _statCard(
                  'New',
                  newOrders.toString(),
                  Icons.notifications_active_outlined,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: _statCard(
                  'Preparing',
                  preparingOrders.toString(),
                  Icons.inventory_2_outlined,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: _statCard(
                  'Shipped',
                  shippedOrders.toString(),
                  Icons.local_shipping_outlined,
                ),
              ),
            ],
          ),

          const SizedBox(height: 29),

          // ---------------------------------------------------------------
          // Recent Orders
          // ---------------------------------------------------------------

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Orders',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: darkText,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: softMint,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${orders.length} orders',
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          ...List.generate(
            orders.length,
            (index) {
              return _orderCard(
                orders[index],
                index,
              );
            },
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Statistics Card
  // -----------------------------------------------------------------------

  Widget _statCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFDCE9E5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 11,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: softMint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 19,
              color: primaryColor,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: darkText,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: secondaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Order Card
  // -----------------------------------------------------------------------

  Widget _orderCard(
    Map<String, dynamic> order,
    int index,
  ) {
    final String status = order['status'];
    final Color color = statusColor(status);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
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
      child: Column(
        children: [
          // ---------------------------------------------------------------
          // Order ID + Status
          // ---------------------------------------------------------------

          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: lightMint,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  order['id'],
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: primaryColor,
                  ),
                ),
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon(status),
                      size: 14,
                      color: color,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // ---------------------------------------------------------------
          // Product Information
          // ---------------------------------------------------------------

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 73,
                height: 73,
                decoration: BoxDecoration(
                  color: imageBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Container(
                    width: 47,
                    height: 47,
                    decoration: const BoxDecoration(
                      color: softMint,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      order['icon'],
                      size: 25,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['product'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                        color: darkText,
                      ),
                    ),

                    const SizedBox(height: 7),

                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline_rounded,
                          size: 13,
                          color: secondaryText,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            order['customer'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: secondaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [
                        const Icon(
                          Icons.shopping_bag_outlined,
                          size: 13,
                          color: secondaryText,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Quantity: ${order['quantity']}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: secondaryText,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 7),

                    Text(
                      '₹${order['price'].toStringAsFixed(0)}',
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

          const SizedBox(height: 14),

          // ---------------------------------------------------------------
          // Date
          // ---------------------------------------------------------------

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: lightMint,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: secondaryText,
                ),
                const SizedBox(width: 7),
                const Text(
                  'Order Date',
                  style: TextStyle(
                    fontSize: 11,
                    color: secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  order['date'],
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: darkText,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 13),

          // ---------------------------------------------------------------
          // Update Button
          // ---------------------------------------------------------------

          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              onPressed: () {
                updateStatus(index);
              },
              icon: Icon(
                status == 'Delivered'
                    ? Icons.check_circle_outline_rounded
                    : Icons.arrow_forward_rounded,
                size: 18,
              ),
              label: Text(
                status == 'New'
                    ? 'Accept & Prepare'
                    : status == 'Preparing'
                        ? 'Mark as Shipped'
                        : status == 'Shipped'
                            ? 'Mark as Delivered'
                            : 'Order Completed',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: status == 'Delivered'
                    ? const Color(0xFFB5C2BF)
                    : primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Product Image Background
  // -----------------------------------------------------------------------

  static const Color imageBackground = Color(0xFFEAF4F1);
}