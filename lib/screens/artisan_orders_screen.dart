import 'package:flutter/material.dart';

class ArtisanOrdersScreen extends StatefulWidget {
  const ArtisanOrdersScreen({super.key});

  @override
  State<ArtisanOrdersScreen> createState() => _ArtisanOrdersScreenState();
}

class _ArtisanOrdersScreenState extends State<ArtisanOrdersScreen> {
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
        const SnackBar(content: Text('This order has already been delivered.')),
      );
      return;
    }

    setState(() {
      orders[index]['status'] = nextStatus;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order ${orders[index]['id']} updated to $nextStatus.'),
      ),
    );
  }

  Color statusColor(String status) {
    if (status == 'Delivered') {
      return const Color(0xFF4CAF50);
    }

    if (status == 'Shipped') {
      return const Color(0xFF1976D2);
    }

    if (status == 'Preparing') {
      return const Color(0xFFFF9800);
    }

    return const Color(0xFF8B4513);
  }

  IconData statusIcon(String status) {
    if (status == 'Delivered') {
      return Icons.check_circle_outline;
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
    final newOrders = orders.where((order) => order['status'] == 'New').length;

    final preparingOrders = orders
        .where((order) => order['status'] == 'Preparing')
        .length;

    final shippedOrders = orders
        .where((order) => order['status'] == 'Shipped')
        .length;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F0),
        elevation: 0,
        foregroundColor: const Color(0xFF5D2E0C),
        title: const Text(
          'Customer Orders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Manage Orders',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D2E0C),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Manage customer orders and update their status.',
            style: TextStyle(fontSize: 15, color: Color(0xFF795548)),
          ),

          const SizedBox(height: 25),

          // Order Statistics
          Row(
            children: [
              Expanded(
                child: _statCard(
                  'New',
                  newOrders.toString(),
                  Icons.notifications_active_outlined,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _statCard(
                  'Preparing',
                  preparingOrders.toString(),
                  Icons.inventory_2_outlined,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _statCard(
                  'Shipped',
                  shippedOrders.toString(),
                  Icons.local_shipping_outlined,
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            'Recent Orders',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D2E0C),
            ),
          ),

          const SizedBox(height: 15),

          ...List.generate(orders.length, (index) {
            return _orderCard(orders[index], index);
          }),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE8D8C8)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: const Color(0xFF8B4513)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D2E0C),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, color: Color(0xFF795548)),
          ),
        ],
      ),
    );
  }

  Widget _orderCard(Map<String, dynamic> order, int index) {
    final String status = order['status'];
    final Color color = statusColor(status);

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8D8C8)),
      ),
      child: Column(
        children: [
          // Order ID + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order['id'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D2E0C),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon(status), size: 15, color: color),
                    const SizedBox(width: 5),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Product
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5E6D3),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  order['icon'],
                  size: 40,
                  color: const Color(0xFF8B4513),
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
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5D2E0C),
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Customer: ${order['customer']}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF795548),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Quantity: ${order['quantity']}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF795548),
                      ),
                    ),

                    const SizedBox(height: 7),

                    Text(
                      '₹${order['price'].toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B4513),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          const Divider(color: Color(0xFFE8D8C8)),

          const SizedBox(height: 8),

          // Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Order Date',
                style: TextStyle(fontSize: 12, color: Color(0xFF795548)),
              ),
              Text(
                order['date'],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D2E0C),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Update Button
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton.icon(
              onPressed: () {
                updateStatus(index);
              },
              icon: Icon(
                status == 'Delivered'
                    ? Icons.check_circle_outline
                    : Icons.arrow_forward,
                size: 19,
              ),
              label: Text(
                status == 'New'
                    ? 'Accept & Prepare'
                    : status == 'Preparing'
                    ? 'Mark as Shipped'
                    : status == 'Shipped'
                    ? 'Mark as Delivered'
                    : 'Order Completed',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: status == 'Delivered'
                    ? Colors.grey
                    : const Color(0xFF8B4513),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
