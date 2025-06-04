// import 'package:flutter/material.dart';
// import 'product_card.dart';

// class ProductList extends StatelessWidget {
//   const ProductList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Simulasi produk, nanti bisa kamu ganti dengan data dari Supabase
//     final products = [
//       {
//         'title': 'Sepatu Pria A',
//         'image': 'https://via.placeholder.com/150',
//         'price': 250000.0
//       },
//       {
//         'title': 'Sepatu Wanita B',
//         'image': 'https://via.placeholder.com/150',
//         'price': 275000.0
//       },
//       {
//         'title': 'Sepatu Anak C',
//         'image': 'https://via.placeholder.com/150',
//         'price': 180000.0
//       },
//     ];

//     return Padding(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("Produk Terbaru", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 16),
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: products.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//               childAspectRatio: 3 / 4,
//             ),
//             itemBuilder: (context, index) {
//               final product = products[index];
//               return ProductCard(
//                 title: product['title']!,
//                 imageUrl: product['image']!,
//                 price: product['price']!,
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
