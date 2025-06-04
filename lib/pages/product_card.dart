// import 'package:flutter/material.dart';
// import 'package:mekki/model/product_model.dart';

// class ProductCard extends StatelessWidget {
//   final String title;
//   final String imageUrl;
//   final double price;

//   const ProductCard({
//     super.key,
//     required this.title,
//     required this.imageUrl,
//     required this.price, required ProductModel product,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.network(imageUrl, height: 120, fit: BoxFit.cover),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text("Rp ${price.toStringAsFixed(0)}"),
//           ),
//         ],
//       ),
//     );
//   }
// }
