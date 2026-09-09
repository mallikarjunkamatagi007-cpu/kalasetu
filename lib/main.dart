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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Artisan Marketplace',

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8B4513)),

        scaffoldBackgroundColor: const Color(0xFFFFF8F0),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFF8F0),
          foregroundColor: Color(0xFF4E342E),
          elevation: 0,
          centerTitle: false,
        ),

        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: Color(0xFF8B4513), width: 1.5),
          ),

          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),

      // First screen shown when the application starts.
      home: const SplashScreen(),

      // Application routes.
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

        // Seller / Artisan section.
        '/artisan-dashboard': (context) => const ArtisanDashboardScreen(),

        '/add-product': (context) => const AddProductScreen(),

        '/ai-listing': (context) => const AiListingScreen(),

        '/my-products': (context) => MyProductsScreen(),

        '/artisan-orders': (context) => const ArtisanOrdersScreen(),
      },
    );
  }
}
