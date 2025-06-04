import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/product_model.dart';

class ProductController {
  static final _supabase = Supabase.instance.client;

  /// ✅ Tambah produk + upload gambar ke storage
  static Future<void> addProductWithBytes({
    required String name,
    required String description,
    required double price,
    required String categoryId,
    required Uint8List imageBytes,
    required String imageName,
    bool isNew = false,
  }) async {
    final imagePath = 'products/$imageName';

    // Upload gambar ke storage
    await _supabase.storage
        .from('product-images')
        .uploadBinary(
          imagePath,
          imageBytes,
          fileOptions: const FileOptions(upsert: true),
        );

    final imageUrl = _supabase.storage
        .from('product-images')
        .getPublicUrl(imagePath);

    // Pastikan user login
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User belum login');

    // Simpan ke tabel products
    final response = await _supabase.from('products').insert({
      'name': name,
      'description': description,
      'price': price,
      'category_id': categoryId,
      'image_url': imageUrl,
      'is_new': isNew,
      'created_by': userId,
      'created_at': DateTime.now().toIso8601String(),
    }).select();

    if (response == null || (response is List && response.isEmpty)) {
      throw Exception('Gagal menambahkan produk: respons kosong');
    }
  }

  /// ✅ Ambil semua produk
  static Future<List<ProductModel>> getAllProducts() async {
    final response = await _supabase.from('products').select();

    if (response == null || response.isEmpty) return [];

    return (response as List)
        .map((item) => ProductModel.fromMap(item))
        .toList();
  }

  /// ✅ Ambil produk berdasarkan kategori
  static Future<List<ProductModel>> getProductsByCategoryId(
    String categoryId,
  ) async {
    final response = await _supabase
        .from('products')
        .select()
        .eq('category_id', categoryId)
        .order('created_at', ascending: false);

    if (response == null || response.isEmpty) return [];

    return (response as List)
        .map((item) => ProductModel.fromMap(item))
        .toList();
  }

  /// ✅ Ambil 1 produk berdasarkan ID
  static Future<ProductModel?> getProductById(String id) async {
    final response =
        await _supabase.from('products').select().eq('id', id).single();

    if (response == null) return null;

    return ProductModel.fromMap(response);
  }

  /// ✅ Hapus produk berdasarkan ID
  static Future<void> deleteProduct(String id) async {
    final response = await _supabase.from('products').delete().eq('id', id);

    if (response == null) {
      throw Exception('Gagal menghapus produk');
    }
  }

  /// ✅ Update produk
  static Future<void> updateProduct({
    required String id,
    required String name,
    required String description,
    required double price,
    required String categoryId,
    required bool isNew,
  }) async {
    final response = await _supabase
        .from('products')
        .update({
          'name': name,
          'description': description,
          'price': price,
          'category_id': categoryId,
          'is_new': isNew,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);

    if (response == null) {
      throw Exception('Gagal mengupdate produk');
    }
  }

  // 🔍 FILTER & SORT PRODUK SECARA LOKAL

  /// ✅ Filter berdasarkan batas harga maksimum
  static List<ProductModel> filterByMaxPrice(
    List<ProductModel> products,
    double maxPrice,
  ) {
    return products.where((product) => product.price <= maxPrice).toList();
  }

  /// ✅ Filter produk yang ditandai sebagai "baru"
  static List<ProductModel> filterByIsNew(List<ProductModel> products) {
    return products.where((product) => product.isNew == true).toList();
  }

  /// ✅ Filter gabungan (harga minimum, maksimum, dan hanya produk baru)
  static List<ProductModel> filterProducts({
    required List<ProductModel> products,
    double? minPrice,
    double? maxPrice,
    bool? onlyNew,
  }) {
    return products.where((product) {
      final matchMinPrice = minPrice == null || product.price >= minPrice;
      final matchMaxPrice = maxPrice == null || product.price <= maxPrice;
      final matchIsNew = onlyNew == null || product.isNew == onlyNew;
      return matchMinPrice && matchMaxPrice && matchIsNew;
    }).toList();
  }

  /// ✅ Sortir produk berdasarkan harga (murah -> mahal atau mahal -> murah)
  static List<ProductModel> sortByPrice(
    List<ProductModel> products,
    bool ascending,
  ) {
    final sorted = [...products];
    sorted.sort((a, b) =>
        ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
    return sorted;
  }
}
