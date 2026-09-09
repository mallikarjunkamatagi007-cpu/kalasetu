class Artisan {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String profileImageUrl;
  final String craftType;
  final String story;
  final String location;
  final double rating;
  final int reviewCount;
  final int productCount;
  final int totalSales;
  final bool isVerified;

  Artisan({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImageUrl,
    required this.craftType,
    required this.story,
    required this.location,
    required this.rating,
    required this.reviewCount,
    required this.productCount,
    required this.totalSales,
    required this.isVerified,
  });

  // Convert Artisan object to Firebase/Firestore data
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'craftType': craftType,
      'story': story,
      'location': location,
      'rating': rating,
      'reviewCount': reviewCount,
      'productCount': productCount,
      'totalSales': totalSales,
      'isVerified': isVerified,
    };
  }

  // Create Artisan object from Firebase/Firestore data
  factory Artisan.fromMap(Map<String, dynamic> map) {
    return Artisan(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      craftType: map['craftType'] ?? '',
      story: map['story'] ?? '',
      location: map['location'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      productCount: map['productCount'] ?? 0,
      totalSales: map['totalSales'] ?? 0,
      isVerified: map['isVerified'] ?? false,
    );
  }

  // Create a modified copy of an Artisan
  Artisan copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImageUrl,
    String? craftType,
    String? story,
    String? location,
    double? rating,
    int? reviewCount,
    int? productCount,
    int? totalSales,
    bool? isVerified,
  }) {
    return Artisan(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      craftType: craftType ?? this.craftType,
      story: story ?? this.story,
      location: location ?? this.location,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      productCount: productCount ?? this.productCount,
      totalSales: totalSales ?? this.totalSales,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
