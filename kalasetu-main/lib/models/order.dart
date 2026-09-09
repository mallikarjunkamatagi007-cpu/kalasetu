class Order {
  final String id;
  final String customerId;
  final String customerName;
  final String artisanId;
  final String artisanName;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String address;
  final String city;
  final String pincode;
  final String paymentMethod;
  final String status;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.artisanId,
    required this.artisanName,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.address,
    required this.city,
    required this.pincode,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
  });

  // Convert Order object to Firebase/Firestore data
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'artisanId': artisanId,
      'artisanName': artisanName,
      'items': items.map((item) => item.toMap()).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'total': total,
      'address': address,
      'city': city,
      'pincode': pincode,
      'paymentMethod': paymentMethod,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create Order object from Firebase/Firestore data
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      customerId: map['customerId'] ?? '',
      customerName: map['customerName'] ?? '',
      artisanId: map['artisanId'] ?? '',
      artisanName: map['artisanName'] ?? '',
      items: (map['items'] as List<dynamic>? ?? [])
          .map((item) => OrderItem.fromMap(Map<String, dynamic>.from(item)))
          .toList(),
      subtotal: (map['subtotal'] ?? 0).toDouble(),
      deliveryFee: (map['deliveryFee'] ?? 0).toDouble(),
      total: (map['total'] ?? 0).toDouble(),
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      pincode: map['pincode'] ?? '',
      paymentMethod: map['paymentMethod'] ?? '',
      status: map['status'] ?? 'Pending',
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  // Create a modified copy of an Order
  Order copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? artisanId,
    String? artisanName,
    List<OrderItem>? items,
    double? subtotal,
    double? deliveryFee,
    double? total,
    String? address,
    String? city,
    String? pincode,
    String? paymentMethod,
    String? status,
    DateTime? createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      artisanId: artisanId ?? this.artisanId,
      artisanName: artisanName ?? this.artisanName,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
      address: address ?? this.address,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

// Individual product inside an order
class OrderItem {
  final String productId;
  final String productName;
  final String artisanId;
  final String artisanName;
  final double price;
  final int quantity;
  final String imageUrl;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.artisanId,
    required this.artisanName,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  double get totalPrice => price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'artisanId': artisanId,
      'artisanName': artisanName,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      artisanId: map['artisanId'] ?? '',
      artisanName: map['artisanName'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      quantity: map['quantity'] ?? 1,
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  OrderItem copyWith({
    String? productId,
    String? productName,
    String? artisanId,
    String? artisanName,
    double? price,
    int? quantity,
    String? imageUrl,
  }) {
    return OrderItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      artisanId: artisanId ?? this.artisanId,
      artisanName: artisanName ?? this.artisanName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
