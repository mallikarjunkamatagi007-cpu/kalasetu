import 'dart:async';

import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'artisan_dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showRoleSelection = false;

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

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() {
        showRoleSelection = true;
      });
    });
  }

  // -----------------------------------------------------------------------
  // Buyer
  // -----------------------------------------------------------------------

  void _openBuyer() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Seller
  // -----------------------------------------------------------------------

  void _openSeller() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const ArtisanDashboardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              22,
              35,
              22,
              30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ---------------------------------------------------------
                // Logo
                // ---------------------------------------------------------

                Container(
                  width: 116,
                  height: 116,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.18),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A7773),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.15),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.handyman_outlined,
                      size: 54,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // ---------------------------------------------------------
                // Brand
                // ---------------------------------------------------------

                const Text(
                  'KalaSetu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 31,
                    fontWeight: FontWeight.w800,
                    color: darkText,
                    letterSpacing: -0.7,
                  ),
                ),

                const SizedBox(height: 7),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: softMint,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'ARTISAN MARKETPLACE',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                      color: primaryColor,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  'Discover. Support. Celebrate.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 15),

                // ---------------------------------------------------------
                // Description
                // ---------------------------------------------------------

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: lightMint,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                      color: const Color(0xFFDCE9E5),
                    ),
                  ),
                  child: const Text(
                    'A digital marketplace connecting talented artisans '
                    'with customers who love handmade products.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.55,
                      color: secondaryText,
                    ),
                  ),
                ),

                const SizedBox(height: 34),

                // ---------------------------------------------------------
                // Role Selection / Loading
                // ---------------------------------------------------------

                if (showRoleSelection) ...[
                  const Text(
                    'How would you like to continue?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    'Choose how you want to use KalaSetu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: secondaryText,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // -------------------------------------------------------
                  // Buyer
                  // -------------------------------------------------------

                  _roleButton(
                    icon: Icons.shopping_bag_outlined,
                    title: 'I am a Buyer',
                    subtitle: 'Shop handmade products',
                    onTap: _openBuyer,
                  ),

                  const SizedBox(height: 13),

                  // -------------------------------------------------------
                  // Seller / Artisan
                  // -------------------------------------------------------

                  _roleButton(
                    icon: Icons.storefront_outlined,
                    title: 'I am an Artisan / Seller',
                    subtitle: 'Sell my handmade products',
                    onTap: _openSeller,
                  ),
                ] else ...[
                  // -------------------------------------------------------
                  // Loading
                  // -------------------------------------------------------

                  const SizedBox(height: 5),

                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: softMint,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(13),
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Preparing your marketplace...',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: secondaryText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],

                const SizedBox(height: 30),

                // ---------------------------------------------------------
                // Bottom Message
                // ---------------------------------------------------------

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite_rounded,
                      size: 13,
                      color: primaryColor,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Supporting independent artisans',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: secondaryText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Role Button
  // -----------------------------------------------------------------------

  Widget _roleButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: cardColor,
        borderRadius: BorderRadius.circular(19),
        child: InkWell(
          borderRadius: BorderRadius.circular(19),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              border: Border.all(
                color: const Color(0xFFDCE9E5),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.025),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                // ---------------------------------------------------------
                // Icon
                // ---------------------------------------------------------

                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: softMint,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: primaryColor,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 14),

                // ---------------------------------------------------------
                // Text
                // ---------------------------------------------------------

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w800,
                          color: darkText,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: secondaryText,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),

                // ---------------------------------------------------------
                // Arrow
                // ---------------------------------------------------------

                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: lightMint,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}