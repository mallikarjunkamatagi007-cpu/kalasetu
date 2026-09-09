import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const List<Map<String, dynamic>> categories = [
    {
      'name': 'Handicrafts',
      'icon': Icons.handyman_outlined,
      'description': 'Unique handmade crafts',
    },
    {
      'name': 'Textiles',
      'icon': Icons.checkroom_outlined,
      'description': 'Traditional fabrics and clothing',
    },
    {
      'name': 'Jewellery',
      'icon': Icons.diamond_outlined,
      'description': 'Handcrafted jewellery',
    },
    {
      'name': 'Pottery',
      'icon': Icons.circle_outlined,
      'description': 'Clay and ceramic products',
    },
    {
      'name': 'Woodwork',
      'icon': Icons.carpenter_outlined,
      'description': 'Beautiful wooden crafts',
    },
    {
      'name': 'Paintings',
      'icon': Icons.palette_outlined,
      'description': 'Traditional and modern art',
    },
    {
      'name': 'Home Decor',
      'icon': Icons.home_outlined,
      'description': 'Handmade decoration',
    },
    {
      'name': 'Bags',
      'icon': Icons.shopping_bag_outlined,
      'description': 'Handmade bags and accessories',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F0),
        elevation: 0,
        foregroundColor: const Color(0xFF5D2E0C),
        title: const Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Explore Categories',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D2E0C),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Find beautiful products made by talented artisans.',
              style: TextStyle(fontSize: 15, color: Color(0xFF795548)),
            ),
            const SizedBox(height: 25),

            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.05,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${category['name']} selected')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE8D8C8)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF5E6D3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              category['icon'],
                              size: 32,
                              color: const Color(0xFF8B4513),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            category['name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5D2E0C),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            category['description'],
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF795548),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
