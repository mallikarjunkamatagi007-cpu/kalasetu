import 'package:flutter/material.dart';

import 'signup_screen.dart';
import 'home_screen.dart';
import 'artisan_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool obscurePassword = true;

  // Default role
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
  static const Color lightMint = Color(0xFFF0F7F4);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // -----------------------------------------------------------------------
  // Login
  // -----------------------------------------------------------------------

  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Buyer goes to marketplace
    if (selectedRole == 'Buyer') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }

    // Seller goes to seller dashboard
    else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const ArtisanDashboardScreen(),
        ),
      );
    }
  }

  // -----------------------------------------------------------------------
  // Role Selection
  // -----------------------------------------------------------------------

  void _selectRole(String role) {
    setState(() {
      selectedRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            22,
            18,
            22,
            30,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------------------------------------------------------
                // Back Button
                // ---------------------------------------------------------

                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: cardColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFDCE9E5),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: darkText,
                      size: 20,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ---------------------------------------------------------
                // Logo
                // ---------------------------------------------------------

                Center(
                  child: Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.18),
                          blurRadius: 18,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.storefront_outlined,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ---------------------------------------------------------
                // App Name
                // ---------------------------------------------------------

                const Center(
                  child: Text(
                    'KalaSetu',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: primaryColor,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // ---------------------------------------------------------
                // Title
                // ---------------------------------------------------------

                const Center(
                  child: Text(
                    'Welcome Back',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.w800,
                      color: darkText,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Center(
                  child: Text(
                    'Sign in to continue to your marketplace',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: secondaryText,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // ---------------------------------------------------------
                // Role Selection
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
                      child: _roleCard(
                        role: 'Buyer',
                        icon: Icons.shopping_bag_outlined,
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: _roleCard(
                        role: 'Seller',
                        icon: Icons.storefront_outlined,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

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

                const SizedBox(height: 19),

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
                    hintText: 'Enter your password',
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
                      return 'Please enter your password';
                    }

                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 7),

                // ---------------------------------------------------------
                // Forgot Password
                // ---------------------------------------------------------

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Password reset will be connected with Firebase later.',
                          ),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                    ),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // ---------------------------------------------------------
                // Login Button
                // ---------------------------------------------------------

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _login,
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
                          Icons.login_rounded,
                          size: 19,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          selectedRole == 'Buyer'
                              ? 'Login as Buyer'
                              : 'Login as Seller',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // ---------------------------------------------------------
                // Divider
                // ---------------------------------------------------------

                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Color(0xFFD6E4E0),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: softMint,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Color(0xFFD6E4E0),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 23),

                // ---------------------------------------------------------
                // Signup
                // ---------------------------------------------------------

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 13,
                        color: secondaryText,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SignupScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ---------------------------------------------------------
                // Bottom Trust Message
                // ---------------------------------------------------------

                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified_outlined,
                        size: 14,
                        color: primaryColor,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'A marketplace for authentic handmade crafts',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: secondaryText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
  // Buyer / Seller Role Card
  // -----------------------------------------------------------------------

  Widget _roleCard({
    required String role,
    required IconData icon,
  }) {
    final bool isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () {
        _selectRole(role);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE3F0ED)
              : cardColor,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: isSelected
                ? primaryColor
                : const Color(0xFFDCE9E5),
            width: isSelected ? 1.6 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor
                    : softMint,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 22,
                color: isSelected
                    ? Colors.white
                    : primaryColor,
              ),
            ),

            const SizedBox(height: 9),

            Text(
              role,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: isSelected
                    ? primaryColor
                    : darkText,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              role == 'Buyer'
                  ? 'Shop handmade products'
                  : 'Sell your handmade products',
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