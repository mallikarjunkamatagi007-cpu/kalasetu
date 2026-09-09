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

  void _openBuyer() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _openSeller() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ArtisanDashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8B4513),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.handyman,
                    size: 60,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  'Artisan Marketplace',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D2E0C),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Discover. Support. Celebrate.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Color(0xFF795548)),
                ),

                const SizedBox(height: 18),

                const Text(
                  'A digital marketplace connecting talented artisans '
                  'with customers who love handmade products.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6D4C41),
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 40),

                // Role selection appears after splash
                if (showRoleSelection) ...[
                  const Text(
                    'How would you like to continue?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E342E),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Buyer
                  _roleButton(
                    icon: Icons.shopping_bag_outlined,
                    title: 'I am a Buyer',
                    subtitle: 'Shop handmade products',
                    onTap: _openBuyer,
                  ),

                  const SizedBox(height: 14),

                  // Seller / Artisan
                  _roleButton(
                    icon: Icons.storefront_outlined,
                    title: 'I am an Artisan / Seller',
                    subtitle: 'Sell my handmade products',
                    onTap: _openSeller,
                  ),
                ] else ...[
                  const SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Color(0xFF8B4513),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _roleButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE8D5C4), width: 1.2),
            ),
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE9D6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(icon, color: const Color(0xFF8B4513), size: 30),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4E342E),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF8D7B70),
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios,
                  size: 17,
                  color: Color(0xFF8B4513),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
