class CartItemModel {
  final String id;
  final String userId;
  final String productId;
  final int size;
  final int quantity;
  final String productName;
  final double productPrice;
  final String productImage; // opsional: tambahkan gambar produk
  final DateTime addedAt;

  CartItemModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.size,
    required this.quantity,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.addedAt,
  });

  double get totalPrice => productPrice * quantity;

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    final product = map['products']; // relasi dari Supabase

    return CartItemModel(
      id: map['id'],
      userId: map['user_id'],
      productId: map['product_id'],
      size: map['size'],
      quantity: map['quantity'],
      productName: product['name'] ?? 'Unknown',
      productPrice: (product['price'] as num).toDouble(),
      productImage: product['image_url'] ?? '',
      addedAt: DateTime.parse(map['added_at']),
    );
  }
}
