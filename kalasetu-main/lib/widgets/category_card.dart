import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final String description;
  final IconData icon;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.name,
    required this.description,
    required this.icon,
    this.onTap,
  });

  static const Color primaryColor = Color(0xFF126B68);
  static const Color darkText = Color(0xFF193B39);
  static const Color secondaryText = Color(0xFF6B7D7A);
  static const Color cardColor = Color(0xFFF9FCFA);
  static const Color softMint = Color(0xFFD9EAE5);

  void _handleTap(BuildContext context) {
    if (onTap != null) {
      onTap!();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$name selected',
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
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleTap(context),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 16, 14, 14),
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
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Category icon
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: softMint,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: primaryColor,
                ),
              ),

              const SizedBox(height: 13),

              // Category name
              Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 6),

              // Category description
              Text(
                description,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w400,
                  height: 1.35,
                  color: secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}