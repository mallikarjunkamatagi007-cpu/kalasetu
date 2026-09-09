import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color backgroundColor = Color(0xFFE8F3EF);
  static const Color cardColor = Color(0xFFF9FCFA);
  static const Color primaryColor = Color(0xFF126B68);
  static const Color darkText = Color(0xFF193B39);
  static const Color secondaryText = Color(0xFF6B7D7A);
  static const Color softMint = Color(0xFFD9EAE5);
  static const Color lightMint = Color(0xFFF0F7F4);

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
          'My Profile',
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
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ========================================================
            // PROFILE CARD
            // ========================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFFD6E5E0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.035),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Profile avatar
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: softMint,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      size: 39,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Name + email
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Manish',
                          style: TextStyle(
                            color: darkText,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'manish@example.com',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: secondaryText,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Edit button
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Edit profile feature will be connected soon.',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: lightMint,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: const Icon(
                        Icons.edit_outlined,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            // ========================================================
            // MY ACCOUNT
            // ========================================================

            _buildSectionTitle('My Account'),

            const SizedBox(height: 11),

            _buildMenuItem(
              context,
              icon: Icons.shopping_bag_outlined,
              title: 'My Orders',
              subtitle: 'View and track your orders',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Orders screen will be connected soon.',
                    ),
                  ),
                );
              },
            ),

            _buildMenuItem(
              context,
              icon: Icons.favorite_border_rounded,
              title: 'Wishlist',
              subtitle: 'View your saved products',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Wishlist screen will be connected soon.',
                    ),
                  ),
                );
              },
            ),

            _buildMenuItem(
              context,
              icon: Icons.location_on_outlined,
              title: 'My Addresses',
              subtitle: 'Manage delivery addresses',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Address management will be connected soon.',
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 23),

            // ========================================================
            // PREFERENCES
            // ========================================================

            _buildSectionTitle('Preferences'),

            const SizedBox(height: 11),

            _buildMenuItem(
              context,
              icon: Icons.notifications_none_rounded,
              title: 'Notifications',
              subtitle: 'Manage notification settings',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Notification settings will be connected soon.',
                    ),
                  ),
                );
              },
            ),

            _buildMenuItem(
              context,
              icon: Icons.language_rounded,
              title: 'Language',
              subtitle: 'English',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Language selection will be connected soon.',
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 23),

            // ========================================================
            // SUPPORT
            // ========================================================

            _buildSectionTitle('Support'),

            const SizedBox(height: 11),

            _buildMenuItem(
              context,
              icon: Icons.help_outline_rounded,
              title: 'Help & Support',
              subtitle: 'Get help with your account',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Help & Support will be connected soon.',
                    ),
                  ),
                );
              },
            ),

            _buildMenuItem(
              context,
              icon: Icons.info_outline_rounded,
              title: 'About KalaSetu',
              subtitle: 'Learn more about our marketplace',
              onTap: () {
                _showAboutDialog(context);
              },
            ),

            const SizedBox(height: 25),

            // ========================================================
            // LOGOUT
            // ========================================================

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  size: 19,
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  side: const BorderSide(
                    color: Color(0xFFE8B9B9),
                  ),
                  backgroundColor: cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ========================================================
            // FOOTER
            // ========================================================

            Center(
              child: Column(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: softMint,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: primaryColor,
                      size: 21,
                    ),
                  ),

                  const SizedBox(height: 9),

                  const Text(
                    'KalaSetu',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Discover. Support. Celebrate.',
                    style: TextStyle(
                      color: secondaryText,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // SECTION TITLE
  // ================================================================

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: darkText,
        fontSize: 19,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  // ================================================================
  // MENU ITEM
  // ================================================================

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFD7E5E1),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(17),
          splashColor: primaryColor.withOpacity(0.06),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 11,
            ),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: lightMint,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: primaryColor,
                    size: 21,
                  ),
                ),

                const SizedBox(width: 13),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: darkText,
                          fontSize: 13.5,
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
                          fontSize: 10.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Arrow
                Container(
                  width: 29,
                  height: 29,
                  decoration: BoxDecoration(
                    color: lightMint,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: primaryColor,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================================================================
  // ABOUT DIALOG
  // ================================================================

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: cardColor,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: softMint,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'KalaSetu',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: darkText,
                  ),
                ),
              ),
            ],
          ),
          content: const Text(
            'An AI-powered marketplace that connects '
            'talented artisans directly with customers '
            'and helps them create professional product listings.',
            style: TextStyle(
              height: 1.5,
              color: secondaryText,
              fontSize: 13,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ================================================================
  // LOGOUT DIALOG
  // ================================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: cardColor,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: darkText,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: secondaryText,
              fontSize: 13,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: secondaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Logout will be connected with Firebase later.',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}