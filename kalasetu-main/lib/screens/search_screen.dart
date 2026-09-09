import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  String searchText = '';

  // Existing product data kept intact.
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
      backgroundColor: const Color(0xFFE8F3EF),

      // ------------------------------------------------------------
      // APP BAR
      // ------------------------------------------------------------
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8F3EF),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: const Color(0xFF193B39),
        titleSpacing: 20,
        title: const Text(
          'Search',
          style: TextStyle(
            color: Color(0xFF193B39),
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      // ------------------------------------------------------------
      // BODY
      // ------------------------------------------------------------
      body: Column(
        children: [

          // ========================================================
          // SEARCH FIELD
          // ========================================================

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 7, 20, 13),
            child: TextField(
              controller: searchController,
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              style: const TextStyle(
                color: Color(0xFF193B39),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: 'Search products, artisans...',
                hintStyle: const TextStyle(
                  color: Color(0xFF82918E),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),

                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF126B68),
                  size: 22,
                ),

                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();

                          setState(() {
                            searchText = '';
                          });
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Color(0xFF6B7D7A),
                          size: 20,
                        ),
                      )
                    : null,

                filled: true,
                fillColor: const Color(0xFFF9FCFA),

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17),
                  borderSide: const BorderSide(
                    color: Color(0xFFD6E5E0),
                  ),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17),
                  borderSide: const BorderSide(
                    color: Color(0xFFD6E5E0),
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17),
                  borderSide: const BorderSide(
                    color: Color(0xFF126B68),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),

          // ========================================================
          // SEARCH RESULT COUNT
          // ========================================================

          if (searchText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9EAE5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${results.length} product(s) found',
                    style: const TextStyle(
                      color: Color(0xFF126B68),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),

          const SizedBox(height: 7),

          // ========================================================
          // RESULTS
          // ========================================================

          Expanded(
            child: results.isEmpty
                ? _emptySearch()
                : GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      8,
                      20,
                      25,
                    ),
                    itemCount: results.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 13,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.68,
                    ),
                    itemBuilder: (context, index) {
                      final product = results[index];

                      return _productCard(
                        context,
                        product,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // EMPTY SEARCH
  // ================================================================

  Widget _emptySearch() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: const Color(0xFFD9EAE5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 39,
                color: Color(0xFF126B68),
              ),
            ),

            const SizedBox(height: 17),

            const Text(
              'No products found',
              style: TextStyle(
                color: Color(0xFF193B39),
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              'Try searching for another product.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6B7D7A),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // PRODUCT CARD
  // ================================================================

  Widget _productCard(
    BuildContext context,
    Map<String, dynamic> product,
  ) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${product['name']} selected',
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color(0xFF126B68),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9FCFA),
          borderRadius: BorderRadius.circular(19),
          border: Border.all(
            color: const Color(0xFFD6E5E0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 11,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // --------------------------------------------------------
            // PRODUCT IMAGE AREA
            // --------------------------------------------------------

            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F7F4),
                    ),
                    child: Center(
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD9EAE5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          product['icon'] as IconData,
                          size: 37,
                          color: const Color(0xFF126B68),
                        ),
                      ),
                    ),
                  ),

                  // Favorite button
                  Positioned(
                    top: 9,
                    right: 9,
                    child: Container(
                      width: 31,
                      height: 31,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FCFA)
                            .withOpacity(0.94),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border_rounded,
                        color: Color(0xFF126B68),
                        size: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --------------------------------------------------------
            // PRODUCT INFORMATION
            // --------------------------------------------------------

            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  11,
                  9,
                  11,
                  10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Product name
                    Text(
                      product['name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF193B39),
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Artisan
                    Text(
                      product['artisan'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF6B7D7A),
                        fontSize: 10.5,
                      ),
                    ),

                    const SizedBox(height: 3),

                    // Category
                    Text(
                      product['category'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF126B68),
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const Spacer(),

                    // Price
                    Text(
                      product['price'],
                      style: const TextStyle(
                        color: Color(0xFF126B68),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}