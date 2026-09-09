import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

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
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F0),
        elevation: 0,
        foregroundColor: const Color(0xFF5D2E0C),
        title: const Text(
          'My Orders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: orders.isEmpty
          ? _buildEmptyOrders()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return _buildOrderCard(context, order);
              },
            ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8D8C8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // Order Header
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
                _buildStatusBadge(order['status']),
              ],
            ),

            const SizedBox(height: 15),

            // Product Information
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5E6D3),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    order['icon'],
                    size: 42,
                    color: const Color(0xFF8B4513),
                  ),
                ),

                const SizedBox(width: 15),

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
                        order['artisan'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF795548),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        '₹${order['price'].toStringAsFixed(0)} × ${order['quantity']}',
                        style: const TextStyle(
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

            const SizedBox(height: 10),

            // Order Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Order Date',
                  style: TextStyle(color: Color(0xFF795548)),
                ),
                Text(
                  order['date'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5D2E0C),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // Track Button
            SizedBox(
              width: double.infinity,
              height: 45,
              child: OutlinedButton(
                onPressed: () {
                  _showOrderDetails(context, order);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF8B4513),
                  side: const BorderSide(color: Color(0xFF8B4513)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  order['status'] == 'Delivered' ? 'View Order' : 'Track Order',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    IconData icon;

    if (status == 'Delivered') {
      icon = Icons.check_circle_outline;
    } else if (status == 'Shipped') {
      icon = Icons.local_shipping_outlined;
    } else {
      icon = Icons.inventory_2_outlined;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: status == 'Delivered'
            ? const Color(0xFFE8F5E9)
            : const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: status == 'Delivered'
                ? const Color(0xFF4CAF50)
                : const Color(0xFF8B4513),
          ),
          const SizedBox(width: 5),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: status == 'Delivered'
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFF8B4513),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderDetails(BuildContext context, Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFFFF8F0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order Tracking',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D2E0C),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Order ID: ${order['id']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF795548),
                ),
              ),

              const SizedBox(height: 20),

              _trackingStep('Order Placed', true, Icons.receipt_long_outlined),

              _trackingStep(
                'Order Processing',
                order['status'] != 'Pending',
                Icons.inventory_2_outlined,
              ),

              _trackingStep(
                'Shipped',
                order['status'] == 'Shipped' || order['status'] == 'Delivered',
                Icons.local_shipping_outlined,
              ),

              _trackingStep(
                'Delivered',
                order['status'] == 'Delivered',
                Icons.check_circle_outline,
              ),

              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }

  Widget _trackingStep(String title, bool completed, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: completed
                  ? const Color(0xFF8B4513)
                  : const Color(0xFFE8D8C8),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: completed ? Colors.white : const Color(0xFF9E9E9E),
              size: 21,
            ),
          ),

          const SizedBox(width: 15),

          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: completed ? FontWeight.bold : FontWeight.normal,
              color: completed
                  ? const Color(0xFF5D2E0C)
                  : const Color(0xFF9E9E9E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyOrders() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: Color(0xFF8B4513),
            ),
            SizedBox(height: 20),
            Text(
              'No Orders Yet',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D2E0C),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Your purchases will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Color(0xFF795548)),
            ),
          ],
        ),
      ),
    );
  }
}
