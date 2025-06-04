import 'package:flutter/material.dart';
import '../../controller/category_controller.dart';
import '../../model/category_model.dart';

class ManageCategoryPage extends StatefulWidget {
  const ManageCategoryPage({super.key});

  @override
  State<ManageCategoryPage> createState() => _ManageCategoryPageState();
}

class _ManageCategoryPageState extends State<ManageCategoryPage> {
  final _controller = CategoryController();
  final _nameController = TextEditingController();
  List<CategoryModel> _categories = [];
  bool _loading = false;

  Future<void> _loadCategories() async {
    setState(() => _loading = true);
    final data = await CategoryController.fetchCategories();
    setState(() {
      _categories = data;
      _loading = false;
    });
  }

  Future<void> _addCategory() async {
    if (_nameController.text.isEmpty) return;
    await CategoryController.addCategory(_nameController.text.trim());
    _nameController.clear();
    await _loadCategories();
  }

  Future<void> _deleteCategory(String id) async {
    await CategoryController.deleteCategory(id);
    await _loadCategories();
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Kategori')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Kategori',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addCategory,
                  child: const Text('Tambah'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _loading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                  child: ListView.builder(
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      return ListTile(
                        title: Text(category.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteCategory(category.id),
                        ),
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
