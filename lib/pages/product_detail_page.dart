import 'package:flutter/material.dart';
import 'package:mekki/controller/cart_controller.dart';
import 'package:mekki/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? selectedSize;
  int selectedQuantity = 1;
  final List<String> sizes = ['40', '41', '42', '43'];

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'TOKOSEPATU',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1.5,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        iconSize: 30,
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.pushNamed(context, '/cart'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _navItem(context, 'Home', '/home'),
                    _navItem(context, 'Pria', '/pria'),
                    _navItem(context, 'Wanita', '/wanita'),
                    _navItem(context, 'Anak', '/anak'),
                    _navItem(context, 'About', '/about'),
                    _navItem(context, 'Contact', '/contact'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar kiri
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.imageUrl.isNotEmpty
                          ? product.imageUrl
                          : 'https://via.placeholder.com/400',
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (product.isNew)
                    Positioned(
                      right: -30,
                      top: 20,
                      child: Transform.rotate(
                        angle: -1.57,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          color: Colors.black,
                          child: const Text(
                            'BARU',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 40),
            // Informasi produk kanan
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'MULTICOLOR / SKU123',
                    style: TextStyle(letterSpacing: 1.1, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Rp ${product.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'PILIH UKURAN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: selectedSize,
                    hint: const Text('Pilih ukuran'),
                    isExpanded: true,
                    items: sizes.map((size) {
                      return DropdownMenuItem(
                        value: size,
                        child: Text(size),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedSize = value);
                    },
                  ),

                  const SizedBox(height: 16),
                  const Text(
                    'JUMLAH',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<int>(
                    value: selectedQuantity,
                    isExpanded: true,
                    items: List.generate(10, (index) => index + 1).map((qty) {
                      return DropdownMenuItem(
                        value: qty,
                        child: Text(qty.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedQuantity = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 16),
                  const Text(
                    'Tersedia',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  ElevatedButton.icon(
                    onPressed: () async {
                      if (selectedSize == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Silakan pilih ukuran terlebih dahulu'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      final parsedSize = int.tryParse(selectedSize!);
                      if (parsedSize == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ukuran tidak valid')),
                          
                        );
                        return;
                      }

                      final userId = Supabase.instance.client.auth.currentUser?.id;
                      if (userId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Anda harus login untuk menambahkan ke keranjang'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      await CartController().addToCart(
                        userId: userId,
                        productId: product.id,
                        size: parsedSize,
                        quantity: selectedQuantity,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Produk ditambahkan ke keranjang')),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('TAMBAH KE KERANJANG', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _navItem(BuildContext context, String label, String route) {
    final isActive = ModalRoute.of(context)?.settings.name == route;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () {
          if (!isActive) {
            Navigator.pushNamed(context, route);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            if (isActive) Container(height: 2, width: 20, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
