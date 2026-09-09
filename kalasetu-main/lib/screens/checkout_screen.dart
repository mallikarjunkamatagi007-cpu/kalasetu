import 'package:flutter/material.dart';

import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final double total;

  const CheckoutScreen({
    super.key,
    required this.total,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
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
  // STATE
  // ================================================================

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

  // ================================================================
  // PLACE ORDER
  // ================================================================

  void placeOrder() {
    if (nameController.text.trim().isEmpty ||
        addressController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty ||
        pincodeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please enter your complete address.',
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OrderSuccessScreen(
          total: widget.total,
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
          'Checkout',
          style: TextStyle(
            color: darkText,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      // ------------------------------------------------------------
      // BODY
      // ------------------------------------------------------------

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          20,
          5,
          20,
          30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ========================================================
            // DELIVERY ADDRESS
            // ========================================================

            _sectionHeader(
              icon: Icons.location_on_outlined,
              title: 'Delivery Address',
            ),

            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFD6E5E0),
                ),
              ),
              child: Column(
                children: [
                  _buildField(
                    controller: nameController,
                    label: 'Full Name',
                    hint: 'Enter your name',
                    icon: Icons.person_outline_rounded,
                  ),

                  const SizedBox(height: 13),

                  _buildField(
                    controller: addressController,
                    label: 'Address',
                    hint: 'House no., street, area',
                    icon: Icons.location_on_outlined,
                  ),

                  const SizedBox(height: 13),

                  _buildField(
                    controller: cityController,
                    label: 'City',
                    hint: 'Enter your city',
                    icon: Icons.location_city_outlined,
                  ),

                  const SizedBox(height: 13),

                  _buildField(
                    controller: pincodeController,
                    label: 'PIN Code',
                    hint: 'Enter 6-digit PIN code',
                    icon: Icons.pin_drop_outlined,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ========================================================
            // PAYMENT METHOD
            // ========================================================

            _sectionHeader(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Payment Method',
            ),

            const SizedBox(height: 14),

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
              icon: Icons.payments_outlined,
              value: 'COD',
            ),

            const SizedBox(height: 14),

            // ========================================================
            // ORDER TOTAL
            // ========================================================

            _buildSummaryCard(),

            const SizedBox(height: 20),

            // ========================================================
            // PLACE ORDER
            // ========================================================

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: placeOrder,
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
                      'Place Order',
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

            const SizedBox(height: 13),

            // Secure checkout text
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_outline_rounded,
                  color: secondaryText,
                  size: 13,
                ),
                SizedBox(width: 5),
                Text(
                  'Your payment information is secure',
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // SECTION HEADER
  // ================================================================

  Widget _sectionHeader({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Container(
          width: 37,
          height: 37,
          decoration: BoxDecoration(
            color: softMint,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            color: primaryColor,
            size: 19,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: darkText,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  // ================================================================
  // TEXT FIELD
  // ================================================================

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
            color: darkText,
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 6),

        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(
            color: darkText,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: secondaryText,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              icon,
              color: primaryColor,
              size: 19,
            ),
            filled: true,
            fillColor: lightMint,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: Color(0xFFDDE9E5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: primaryColor,
                width: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ================================================================
  // PAYMENT OPTION
  // ================================================================

  Widget _paymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
  }) {
    final bool selected = paymentMethod == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          paymentMethod = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 11),
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: selected
                ? primaryColor
                : const Color(0xFFD6E5E0),
            width: selected ? 1.6 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                color: selected
                    ? softMint
                    : lightMint,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                icon,
                color: primaryColor,
                size: 21,
              ),
            ),

            const SizedBox(width: 12),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: darkText,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: secondaryText,
                      fontSize: 9.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Radio indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 21,
              height: 21,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? primaryColor
                      : const Color(0xFF9EAFAB),
                  width: selected ? 6 : 1.5,
                ),
                color: cardColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // SUMMARY CARD
  // ================================================================

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFD6E5E0),
        ),
      ),
      child: Column(
        children: [
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
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          _summaryRow(
            'Items',
            '₹${widget.total.toStringAsFixed(0)}',
          ),

          const SizedBox(height: 9),

          _summaryRow(
            'Delivery',
            'Included',
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              color: Color(0xFFDDE9E5),
              height: 1,
            ),
          ),

          _summaryRow(
            'Total',
            '₹${widget.total.toStringAsFixed(0)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  // ================================================================
  // SUMMARY ROW
  // ================================================================

  Widget _summaryRow(
    String title,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 15 : 12,
            fontWeight:
                isTotal ? FontWeight.w800 : FontWeight.w500,
            color: isTotal ? darkText : secondaryText,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 17 : 12.5,
            fontWeight: FontWeight.w800,
            color: isTotal ? primaryColor : darkText,
          ),
        ),
      ],
    );
  }
}