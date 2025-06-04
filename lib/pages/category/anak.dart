import 'package:flutter/material.dart';
import 'package:mekki/controller/product_controller.dart';
import 'package:mekki/model/product_model.dart';
import 'package:mekki/pages/product_detail_page.dart';
import 'package:mekki/widgets/about_section.dart';
import 'package:mekki/widgets/footer_widget.dart';

class AnakPage extends StatefulWidget {
  const AnakPage({super.key});

  @override
  State<AnakPage> createState() => _AnakPageState();
}

class _AnakPageState extends State<AnakPage> {
  List<ProductModel> _products = [];
  bool _isLoading = true;

  final String anakCategoryId =
      'bce25a74-b991-43aa-a95b-fcb391315a38'; // Ganti dengan ID kategori "Anak" milikmu

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final data = await ProductController.getProductsByCategoryId(
        anakCategoryId,
      );
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
              child: Row(
                children: [
                  GestureDetector(
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'ANAK',
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
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterItem('HARGA'),
                        _buildFilterItem('UKURAN'),
                        _buildFilterItem('DISKON'),
                        _buildFilterItem('GENDER'),
                        _buildFilterItem('TIPE PRODUK'),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'LEBIH BANYAK FILTER',
                              style: TextStyle(
                                letterSpacing: 1.2,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        _buildFilterItem('REKOMENDASI'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
                                Text(
                                  product.categoryId,
                                  style: const TextStyle(
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

  Widget _buildFilterItem(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: title,
          icon: const Icon(Icons.keyboard_arrow_down),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
          onChanged: (value) {},
          items: [DropdownMenuItem(value: title, child: Text(title))],
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
