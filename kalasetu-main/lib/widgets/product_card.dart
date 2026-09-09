import 'package:flutter/material.dart';

import '../screens/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback? onFavorite;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.onFavorite,
    this.onAddToCart,
  });

  static const Color primaryColor = Color(0xFF126B68);
  static const Color darkText = Color(0xFF193B39);
  static const Color secondaryText = Color(0xFF6B7D7A);
  static const Color cardColor = Color(0xFFF9FCFA);
  static const Color imageBackground = Color(0xFFEAF4F1);
  static const Color softMint = Color(0xFFD9EAE5);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                product: product,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFDCEBE7),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.035),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: imageBackground,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: _buildProductImage(),
                    ),

                    // Favorite button
                    Positioned(
                      top: 9,
                      right: 9,
                      child: Material(
                        color: Colors.white.withOpacity(0.95),
                        shape: const CircleBorder(),
                        elevation: 1,
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            if (onFavorite != null) {
                              onFavorite!();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'Added to wishlist.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  margin: const EdgeInsets.all(16),
                                ),
                              );
                            }
                          },
                          child: const SizedBox(
                            width: 38,
                            height: 38,
                            child: Icon(
                              Icons.favorite_border_rounded,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Product information
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 12, 13, 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category
                    if (product['category'] != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: softMint,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text(
                          product['category'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                    const SizedBox(height: 7),

                    // Product name
                    Text(
                      product['name']?.toString() ?? 'Product',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.5,
                        height: 1.25,
                        fontWeight: FontWeight.w700,
                        color: darkText,
                      ),
                    ),

                    // Artisan
                    if (product['artisan'] != null) ...[
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.person_outline_rounded,
                            size: 13,
                            color: secondaryText,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              product['artisan'].toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color: secondaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 10),

                    // Price + cart button
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _formatPrice(product['price']),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: primaryColor,
                            ),
                          ),
                        ),

                        Material(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(11),
                          child: InkWell(
                            onTap: () {
                              if (onAddToCart != null) {
                                onAddToCart!();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${product['name'] ?? 'Product'} added to cart.',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    margin: const EdgeInsets.all(16),
                                  ),
                                );
                              }
                            },
                            borderRadius: BorderRadius.circular(11),
                            child: const SizedBox(
                              width: 38,
                              height: 38,
                              child: Icon(
                                Icons.add_shopping_cart_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    final image = product['image'];

    // Display an actual File image when one is supplied.
    if (image != null) {
      try {
        if (image.runtimeType.toString() == 'File') {
          return Image.file(
            image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildIconPlaceholder();
            },
          );
        }
      } catch (_) {
        // Fall back to the icon placeholder.
      }
    }

    return _buildIconPlaceholder();
  }

  Widget _buildIconPlaceholder() {
    return Center(
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.72),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Icon(
          product['icon'] ?? Icons.shopping_bag_outlined,
          size: 36,
          color: primaryColor,
        ),
      ),
    );
  }

  String _formatPrice(dynamic price) {
    if (price is num) {
      return '₹${price.toStringAsFixed(0)}';
    }

    if (price == null) {
      return '₹0';
    }

    return '₹$price';
  }
}