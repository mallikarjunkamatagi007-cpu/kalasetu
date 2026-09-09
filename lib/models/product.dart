class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final String artisanId;
  final String artisanName;
  final String imageUrl;
  final double price;
  final int stock;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final String material;
  final String location;
  final bool isActive;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.artisanId,
    required this.artisanName,
    required this.imageUrl,
    required this.price,
    required this.stock,
    required this.rating,
    required this.reviewCount,
    required this.tags,
    required this.material,
    required this.location,
    required this.isActive,
  });

  // Convert Product object to Firebase/Firestore data
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'artisanId': artisanId,
      'artisanName': artisanName,
      'imageUrl': imageUrl,
      'price': price,
      'stock': stock,
      'rating': rating,
      'reviewCount': reviewCount,
      'tags': tags,
      'material': material,
      'location': location,
      'isActive': isActive,
    };
  }

  // Create Product object from Firebase/Firestore data
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      artisanId: map['artisanId'] ?? '',
      artisanName: map['artisanName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      stock: map['stock'] ?? 0,
      rating: (map['rating'] ?? 0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      tags: List<String>.from(map['tags'] ?? []),
      material: map['material'] ?? '',
      location: map['location'] ?? '',
      isActive: map['isActive'] ?? true,
    );
  }

  // Create a modified copy of a Product
  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? artisanId,
    String? artisanName,
    String? imageUrl,
    double? price,
    int? stock,
    double? rating,
    int? reviewCount,
    List<String>? tags,
    String? material,
    String? location,
    bool? isActive,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      artisanId: artisanId ?? this.artisanId,
      artisanName: artisanName ?? this.artisanName,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      tags: tags ?? this.tags,
      material: material ?? this.material,
      location: location ?? this.location,
      isActive: isActive ?? this.isActive,
    );
  }
}
