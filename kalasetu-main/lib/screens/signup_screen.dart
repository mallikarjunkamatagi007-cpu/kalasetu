import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'artisan_dashboard_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  // Default account type
  String selectedRole = 'Buyer';

  // -----------------------------------------------------------------------
  // KalaSetu Theme
  // -----------------------------------------------------------------------

  static const Color backgroundColor = Color(0xFFE8F3EF);
  static const Color cardColor = Color(0xFFF9FCFA);
  static const Color primaryColor = Color(0xFF126B68);
  static const Color darkText = Color(0xFF193B39);
  static const Color secondaryText = Color(0xFF6B7D7A);
  static const Color softMint = Color(0xFFD9EAE5);

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // -----------------------------------------------------------------------
  // Create Account
  // -----------------------------------------------------------------------

  void createAccount() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // BUYER
    if (selectedRole == 'Buyer') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    }

    // SELLER
    else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const ArtisanDashboardScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // -------------------------------------------------------------------
      // App Bar
      // -------------------------------------------------------------------

      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: darkText,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 20,
        title: const Text(
          'Create Account',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: darkText,
          ),
        ),
      ),

      // -------------------------------------------------------------------
      // Body
      // -------------------------------------------------------------------

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            22,
            10,
            22,
            30,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------------------------------------------------------
                // Logo
                // ---------------------------------------------------------

                Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(21),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.16),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.storefront_outlined,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                const Center(
                  child: Text(
                    'KalaSetu',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: primaryColor,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // ---------------------------------------------------------
                // Heading
                // ---------------------------------------------------------

                const Center(
                  child: Text(
                    'Join KalaSetu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: darkText,
                      letterSpacing: -0.4,
                    ),
                  ),
                ),

                const SizedBox(height: 7),

                const Center(
                  child: Text(
                    'Create an account to discover or sell handmade products.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.4,
                      color: secondaryText,
                    ),
                  ),
                ),

                const SizedBox(height: 27),

                // ---------------------------------------------------------
                // Account Type
                // ---------------------------------------------------------

                const Text(
                  'I am a',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 11),

                Row(
                  children: [
                    Expanded(
                      child: _roleButton(
                        title: 'Buyer',
                        subtitle: 'Shop handmade products',
                        icon: Icons.shopping_bag_outlined,
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: _roleButton(
                        title: 'Seller',
                        subtitle: 'Sell your handmade products',
                        icon: Icons.storefront_outlined,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 23),

                // ---------------------------------------------------------
                // Full Name
                // ---------------------------------------------------------

                const Text(
                  'Full Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: _inputDecoration(
                    hintText: 'Enter your full name',
                    icon: Icons.person_outline_rounded,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter your name';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 17),

                // ---------------------------------------------------------
                // Email
                // ---------------------------------------------------------

                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration(
                    hintText: 'Enter your email',
                    icon: Icons.email_outlined,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 17),

                // ---------------------------------------------------------
                // Password
                // ---------------------------------------------------------

                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: _inputDecoration(
                    hintText: 'Create a password',
                    icon: Icons.lock_outline_rounded,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword =
                              !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: secondaryText,
                        size: 20,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }

                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 17),

                // ---------------------------------------------------------
                // Confirm Password
                // ---------------------------------------------------------

                const Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: obscureConfirmPassword,
                  decoration: _inputDecoration(
                    hintText: 'Confirm your password',
                    icon: Icons.lock_outline_rounded,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword =
                              !obscureConfirmPassword;
                        });
                      },
                      icon: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: secondaryText,
                        size: 20,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }

                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 27),

                // ---------------------------------------------------------
                // Create Account Button
                // ---------------------------------------------------------

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: createAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person_add_alt_1_rounded,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          selectedRole == 'Seller'
                              ? 'Create Seller Account'
                              : 'Create Buyer Account',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 19),

                // ---------------------------------------------------------
                // Login Link
                // ---------------------------------------------------------

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                    ),
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ---------------------------------------------------------
                // Trust Message
                // ---------------------------------------------------------

                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F7F4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified_outlined,
                          size: 14,
                          color: primaryColor,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Connect with authentic handmade crafts',
                          style: TextStyle(
                            fontSize: 10.5,
                            color: secondaryText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Input Decoration
  // -----------------------------------------------------------------------

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 13,
        color: Color(0xFF9AA8A5),
      ),
      prefixIcon: Icon(
        icon,
        color: primaryColor,
        size: 20,
      ),
      suffixIcon: suffix,
      filled: true,
      fillColor: cardColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFDCE9E5),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFDCE9E5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 1.4,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFE08B8B),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFE08B8B),
          width: 1.4,
        ),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Buyer / Seller Selection
  // -----------------------------------------------------------------------

  Widget _roleButton({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final bool selected = selectedRole == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = title;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 9,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFE3F0ED)
              : cardColor,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: selected
                ? primaryColor
                : const Color(0xFFDCE9E5),
            width: selected ? 1.6 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.07),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                color: selected
                    ? primaryColor
                    : softMint,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 21,
                color: selected
                    ? Colors.white
                    : primaryColor,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: selected
                    ? primaryColor
                    : darkText,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                height: 1.3,
                color: secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}