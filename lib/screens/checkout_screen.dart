import 'package:flutter/material.dart';

import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final double total;

  const CheckoutScreen({super.key, required this.total});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String paymentMethod = 'UPI';

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  void placeOrder() {
    if (nameController.text.trim().isEmpty ||
        addressController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty ||
        pincodeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your complete address.')),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OrderSuccessScreen(total: widget.total),
      ),
    );
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
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery Address',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D2E0C),
              ),
            ),

            const SizedBox(height: 15),

            _buildField(
              controller: nameController,
              label: 'Full Name',
              hint: 'Enter your name',
              icon: Icons.person_outline,
            ),

            const SizedBox(height: 15),

            _buildField(
              controller: addressController,
              label: 'Address',
              hint: 'House no., street, area',
              icon: Icons.location_on_outlined,
            ),

            const SizedBox(height: 15),

            _buildField(
              controller: cityController,
              label: 'City',
              hint: 'Enter your city',
              icon: Icons.location_city_outlined,
            ),

            const SizedBox(height: 15),

            _buildField(
              controller: pincodeController,
              label: 'PIN Code',
              hint: 'Enter 6-digit PIN code',
              icon: Icons.pin_drop_outlined,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 30),

            const Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D2E0C),
              ),
            ),

            const SizedBox(height: 15),

            _paymentOption(
              title: 'UPI',
              subtitle: 'Google Pay, PhonePe, Paytm and more',
              icon: Icons.account_balance_wallet_outlined,
              value: 'UPI',
            ),

            _paymentOption(
              title: 'Credit / Debit Card',
              subtitle: 'Visa, Mastercard and more',
              icon: Icons.credit_card_outlined,
              value: 'Card',
            ),

            _paymentOption(
              title: 'Cash on Delivery',
              subtitle: 'Pay when your order arrives',
              icon: Icons.money_outlined,
              value: 'COD',
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE8D8C8)),
              ),
              child: Column(
                children: [
                  _summaryRow('Items', '₹${widget.total.toStringAsFixed(0)}'),
                  const SizedBox(height: 10),
                  _summaryRow('Delivery', 'Included'),
                  const Divider(height: 25),
                  _summaryRow(
                    'Total',
                    '₹${widget.total.toStringAsFixed(0)}',
                    isTotal: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B4513),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF5D2E0C),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _paymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: paymentMethod == value
              ? const Color(0xFF8B4513)
              : const Color(0xFFE8D8C8),
          width: paymentMethod == value ? 2 : 1,
        ),
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: paymentMethod,
        onChanged: (newValue) {
          setState(() {
            paymentMethod = newValue!;
          });
        },
        activeColor: const Color(0xFF8B4513),
        title: Row(
          children: [
            Icon(icon, color: const Color(0xFF8B4513)),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D2E0C),
              ),
            ),
          ],
        ),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _summaryRow(String title, String value, {bool isTotal = false}) {
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
}
