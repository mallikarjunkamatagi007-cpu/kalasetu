import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  String searchText = '';

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Handmade Clay Pot',
      'artisan': 'Meera Crafts',
      'category': 'Pottery',
      'price': '₹450',
      'icon': Icons.local_florist_outlined,
    },
    {
      'name': 'Traditional Handwoven Saree',
      'artisan': 'Sita Handlooms',
      'category': 'Textiles',
      'price': '₹1,800',
      'icon': Icons.checkroom_outlined,
    },
    {
      'name': 'Wooden Decorative Box',
      'artisan': 'Ravi Woodworks',
      'category': 'Woodwork',
      'price': '₹750',
      'icon': Icons.inventory_2_outlined,
    },
    {
      'name': 'Handcrafted Necklace',
      'artisan': 'Asha Jewellery',
      'category': 'Jewellery',
      'price': '₹950',
      'icon': Icons.diamond_outlined,
    },
    {
      'name': 'Traditional Wall Painting',
      'artisan': 'Kiran Arts',
      'category': 'Paintings',
      'price': '₹1,200',
      'icon': Icons.palette_outlined,
    },
    {
      'name': 'Handmade Jute Bag',
      'artisan': 'Anita Crafts',
      'category': 'Bags',
      'price': '₹550',
      'icon': Icons.shopping_bag_outlined,
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    if (searchText.trim().isEmpty) {
      return products;
    }

    final query = searchText.toLowerCase();

    return products.where((product) {
      return product['name'].toString().toLowerCase().contains(query) ||
          product['artisan'].toString().toLowerCase().contains(query) ||
          product['category'].toString().toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = filteredProducts;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F0),
        elevation: 0,
        foregroundColor: const Color(0xFF5D2E0C),
        title: const Text(
          'Search',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: TextField(
              controller: searchController,
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search products, artisans...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF8B4513)),
                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            searchText = '';
                          });
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xFFE8D8C8)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xFFE8D8C8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color(0xFF8B4513),
                    width: 2,
                  ),
                ),
              ),
            ),
          ),

          if (searchText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${results.length} product(s) found',
                  style: const TextStyle(
                    color: Color(0xFF795548),
                    fontSize: 14,
                  ),
                ),
              ),
            ),

          const SizedBox(height: 10),

          Expanded(
            child: results.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 65,
                          color: Color(0xFFBCAAA4),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5D2E0C),
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Try searching for another product.',
                          style: TextStyle(color: Color(0xFF795548)),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: results.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.70,
                        ),
                    itemBuilder: (context, index) {
                      final product = results[index];

                      return GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product['name']} selected'),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE8D8C8)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF5E6D3),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                  ),
                                  child: Icon(
                                    product['icon'],
                                    size: 55,
                                    color: Color(0xFF8B4513),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['name'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF5D2E0C),
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      product['artisan'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF795548),
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      product['category'],
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF9E9E9E),
                                      ),
                                    ),

                                    const SizedBox(height: 7),

                                    Text(
                                      product['price'],
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF8B4513),
                                      ),
                                    ),
                                  ],
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
    );
  }
}
