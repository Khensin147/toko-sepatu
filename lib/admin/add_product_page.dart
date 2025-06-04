import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mekki/controller/product_controller.dart';
import 'package:mekki/controller/category_controller.dart';
import 'package:mekki/model/category_model.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';
  double price = 0;
  CategoryModel? selectedCategory;
  Uint8List? imageBytes;
  String? imageName;
  bool isNew = false;

  final picker = ImagePicker();
  List<CategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    final data = await CategoryController.fetchCategories();
    setState(() {
      categories = data;
      if (data.isNotEmpty) selectedCategory = data[0];
    });
  }

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        imageBytes = bytes;
        imageName = picked.name;
      });
    }
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate() ||
        imageBytes == null ||
        selectedCategory == null)
      return;
    _formKey.currentState!.save();

    try {
      await ProductController.addProductWithBytes(
        name: name,
        description: description,
        price: price,
        categoryId: selectedCategory!.id,
        imageBytes: imageBytes!,
        imageName: imageName ?? 'image.jpg',
        isNew: isNew,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produk berhasil ditambahkan!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Produk")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nama Produk'),
                onSaved: (val) => name = val!,
                validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Deskripsi Produk',
                ),
                maxLines: 3,
                onSaved: (val) => description = val!,
                validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                onSaved: (val) => price = double.tryParse(val ?? '0') ?? 0,
                validator: (val) {
                  final parsed = double.tryParse(val ?? '');
                  if (val == null || val.isEmpty) return 'Wajib diisi';
                  if (parsed == null || parsed <= 0) return 'Harga tidak valid';
                  return null;
                },
              ),
              DropdownButtonFormField<CategoryModel>(
                value: selectedCategory,
                items:
                    categories.map((cat) {
                      return DropdownMenuItem(
                        value: cat,
                        child: Text(cat.name),
                      );
                    }).toList(),
                onChanged: (val) {
                  setState(() => selectedCategory = val);
                },
                decoration: const InputDecoration(labelText: 'Kategori'),
                validator:
                    (val) => val == null ? 'Kategori harus dipilih' : null,
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: isNew,
                onChanged: (val) {
                  setState(() => isNew = val ?? false);
                },
                title: const Text('Tandai sebagai produk baru'),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Pilih Gambar'),
              ),
              if (imageBytes != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Image.memory(imageBytes!, height: 150),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: submit,
                child: const Text('Simpan Produk'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
