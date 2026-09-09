import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/search_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/wishlist_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/artisan_dashboard_screen.dart';
import 'screens/add_product_screen.dart';
import 'screens/ai_listing_screen.dart';
import 'screens/my_products_screen.dart';
import 'screens/artisan_orders_screen.dart';

void main() {
  runApp(const ArtisanMarketplaceApp());
}

class ArtisanMarketplaceApp extends StatelessWidget {
  const ArtisanMarketplaceApp({super.key});

  // ------------------------------------------------------------
  // App colors
  // ------------------------------------------------------------

  static const Color backgroundColor = Color(0xFFE8F3EF);
  static const Color cardColor = Color(0xFFF9FCFA);
  static const Color primaryColor = Color(0xFF126B68);
  static const Color darkText = Color(0xFF193B39);
  static const Color secondaryText = Color(0xFF6B7D7A);
  static const Color softMint = Color(0xFFD9EAE5);
  static const Color lightMint = Color(0xFFF0F7F4);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Artisan Marketplace',

      // ------------------------------------------------------------
      // Global application theme
      // ------------------------------------------------------------

      theme: ThemeData(
        useMaterial3: true,

        fontFamily: 'Roboto',

        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
        ).copyWith(
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: const Color(0xFF4D8A83),
          surface: cardColor,
          onSurface: darkText,
        ),

        scaffoldBackgroundColor: backgroundColor,

        // ----------------------------------------------------------
        // App Bar
        // ----------------------------------------------------------

        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          foregroundColor: darkText,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: darkText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          iconTheme: IconThemeData(
            color: darkText,
            size: 23,
          ),
        ),

        // ----------------------------------------------------------
        // Input fields
        // ----------------------------------------------------------

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: cardColor,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),

          hintStyle: const TextStyle(
            color: secondaryText,
            fontSize: 14,
          ),

          labelStyle: const TextStyle(
            color: secondaryText,
            fontSize: 14,
          ),

          prefixIconColor: secondaryText,

          suffixIconColor: secondaryText,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFFDCEBE7),
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFFDCEBE7),
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: primaryColor,
              width: 1.5,
            ),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFFD66A6A),
              width: 1,
            ),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFFD66A6A),
              width: 1.5,
            ),
          ),
        ),

        // ----------------------------------------------------------
        // Elevated buttons
        // ----------------------------------------------------------

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            shadowColor: Colors.transparent,

            minimumSize: const Size(
              double.infinity,
              52,
            ),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),

            textStyle: const TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        // ----------------------------------------------------------
        // Outlined buttons
        // ----------------------------------------------------------

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,

            minimumSize: const Size(
              double.infinity,
              52,
            ),

            side: const BorderSide(
              color: primaryColor,
              width: 1.5,
            ),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),

            textStyle: const TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        // ----------------------------------------------------------
        // Text buttons
        // ----------------------------------------------------------

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        // ----------------------------------------------------------
        // Cards
        // ----------------------------------------------------------

        cardTheme: CardThemeData(
          color: cardColor,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(
              color: Color(0xFFDCEBE7),
              width: 1,
            ),
          ),
        ),

        // ----------------------------------------------------------
        // Divider
        // ----------------------------------------------------------

        dividerTheme: const DividerThemeData(
          color: Color(0xFFDCEBE7),
          thickness: 1,
          space: 1,
        ),

        // ----------------------------------------------------------
        // Icon theme
        // ----------------------------------------------------------

        iconTheme: const IconThemeData(
          color: primaryColor,
          size: 22,
        ),

        // ----------------------------------------------------------
        // Bottom navigation
        // ----------------------------------------------------------

        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: cardColor,
          elevation: 0,
          indicatorColor: softMint,

          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(
                  color: primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                );
              }

              return const TextStyle(
                color: secondaryText,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              );
            },
          ),

          iconTheme: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(
                  color: primaryColor,
                  size: 23,
                );
              }

              return const IconThemeData(
                color: secondaryText,
                size: 22,
              );
            },
          ),
        ),

        // ----------------------------------------------------------
        // Snackbars
        // ----------------------------------------------------------

        snackBarTheme: SnackBarThemeData(
          backgroundColor: primaryColor,
          contentTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          insetPadding: const EdgeInsets.all(16),
        ),

        // ----------------------------------------------------------
        // Dialogs
        // ----------------------------------------------------------

        dialogTheme: DialogThemeData(
          backgroundColor: cardColor,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          titleTextStyle: const TextStyle(
            color: darkText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          contentTextStyle: const TextStyle(
            color: secondaryText,
            fontSize: 14,
            height: 1.4,
          ),
        ),

        // ----------------------------------------------------------
        // Popup menus
        // ----------------------------------------------------------

        popupMenuTheme: PopupMenuThemeData(
          color: cardColor,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            color: darkText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        // ----------------------------------------------------------
        // Chip theme
        // ----------------------------------------------------------

        chipTheme: ChipThemeData(
          backgroundColor: softMint,
          selectedColor: primaryColor,
          disabledColor: const Color(0xFFE1EAE7),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelStyle: const TextStyle(
            color: darkText,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          secondaryLabelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ------------------------------------------------------------
      // First screen shown when the application starts
      // ------------------------------------------------------------

      home: const SplashScreen(),

      // ------------------------------------------------------------
      // Application routes
      // ------------------------------------------------------------

      routes: {
        '/login': (context) => const LoginScreen(),

        '/signup': (context) => const SignupScreen(),

        '/home': (context) => const HomeScreen(),

        '/categories': (context) => const CategoriesScreen(),

        '/search': (context) => const SearchScreen(),

        '/cart': (context) => const CartScreen(),

        '/orders': (context) => const OrdersScreen(),

        '/wishlist': (context) => const WishlistScreen(),

        '/profile': (context) => const ProfileScreen(),

        // ----------------------------------------------------------
        // Seller / Artisan section
        // ----------------------------------------------------------

        '/artisan-dashboard': (context) =>
            const ArtisanDashboardScreen(),

        '/add-product': (context) =>
            const AddProductScreen(),

        '/ai-listing': (context) =>
            const AiListingScreen(),

        '/my-products': (context) =>
            MyProductsScreen(),

        '/artisan-orders': (context) =>
            const ArtisanOrdersScreen(),
      },
    );
  }
}