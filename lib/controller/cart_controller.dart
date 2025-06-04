import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/cart_item_model.dart';

class CartController {
  final supabase = Supabase.instance.client;

  // ✅ Ambil item keranjang berdasarkan user
  Future<List<CartItemModel>> getCartItems(String userId) async {
    final response = await supabase
        .from('cart_items')
        .select('*, products(*)')
        .eq('user_id', userId)
        .order('added_at', ascending: false);

    return (response as List)
        .map((item) => CartItemModel.fromMap(item))
        .toList();
  }

  // ✅ Tambah item ke keranjang
  Future<void> addToCart({
    required String userId,
    required String productId,
    required int size,
    required int quantity,
  }) async {
    await supabase.from('cart_items').insert({
      'user_id': userId,
      'product_id': productId,
      'size': size,
      'quantity': quantity,
      'added_at': DateTime.now().toIso8601String(),
    });
  }

  // ✅ Hapus item dari keranjang
  Future<void> deleteCartItem(String cartItemId) async {
    await supabase.from('cart_items').delete().eq('id', cartItemId);
  }

  // (Opsional) Kosongkan seluruh keranjang
  Future<void> clearCart(String userId) async {
    await supabase.from('cart_items').delete().eq('user_id', userId);
  }
}
