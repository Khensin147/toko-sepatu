import 'package:flutter/material.dart';
import 'package:mekki/model/product_model.dart';

class ProductCardAdmin extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onDelete;

  const ProductCardAdmin({
    super.key,
    required this.product,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Image.network(
          product.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(product.name),
        subtitle: Text("Rp ${product.price.toStringAsFixed(0)}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
