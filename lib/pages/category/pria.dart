import 'package:flutter/material.dart';
import 'package:mekki/controller/product_controller.dart';
import 'package:mekki/model/product_model.dart';
import 'package:mekki/pages/product_detail_page.dart';
import 'package:mekki/widgets/about_section.dart';
import 'package:mekki/widgets/filter_bar.dart';
import 'package:mekki/widgets/footer_widget.dart';

class PriaPage extends StatefulWidget {
  const PriaPage({super.key});

  @override
  State<PriaPage> createState() => _PriaPageState();
}

class _PriaPageState extends State<PriaPage> {
  List<ProductModel> _products = [];
  bool _isLoading = true;

  final String priaCategoryId = '75f0c148-3dd2-4abb-bbef-261a6b824e0a';

  String? selectedFilter;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final data = await ProductController.getProductsByCategoryId(
        priaCategoryId,
      );

      // Default sorting (misalnya berdasarkan nama produk)
      data.sort((a, b) => a.name.compareTo(b.name));

      setState(() {
        _products = data;
        _isLoading = false;
      });
    } catch (e, stack) {
      print('Error fetching products: $e');
      print('Stacktrace: $stack');
      setState(() => _isLoading = false);
    }
  }

  void _applyFilter(String filterType) async {
    setState(() => _isLoading = true);

    try {
      List<ProductModel> filteredProducts =
          await ProductController.getProductsByCategoryId(priaCategoryId);

      switch (filterType) {
        case 'HARGA':
          filteredProducts.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'NAMA':
          filteredProducts.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'TERBARU':
          filteredProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          break;
      }

      setState(() {
        selectedFilter = filterType;
        _products = filteredProducts;
        _isLoading = false;
      });
    } catch (e) {
      print('Filter error: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        onPressed: () {
                          Navigator.pushNamed(context, '/cart');
                        },
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back, size: 18, color: Colors.black),
                    SizedBox(width: 4),
                    Text(
                      'KEMBALI',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'PRIA',
                    style: TextStyle(
                      fontSize: 32,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '[${_products.length}]',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),

            // 🔽 Filter Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: FilterBar(
                selectedFilter: selectedFilter,
                onFilterSelected: (filter) {
                  _applyFilter(filter);
                },
              ),
            ),

            // 🔽 Produk Grid
            Padding(
              padding: const EdgeInsets.all(24),
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _products.isEmpty
                      ? const Center(
                        child: Text('Belum ada produk untuk kategori ini.'),
                      )
                      : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 3 : 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 32,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          final product = _products[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          ProductDetailPage(product: product),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          product.imageUrl.isNotEmpty
                                              ? product.imageUrl
                                              : 'https://via.placeholder.com/150',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    if (product.isNew == true)
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          child: const Text(
                                            'BARU',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    const Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Icon(
                                        Icons.favorite_border,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Pria',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Rp ${product.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
            const AboutSection(),
            const FooterWidget(),
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
