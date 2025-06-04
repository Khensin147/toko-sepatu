import 'package:mekki/model/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryController {
  static final _client = Supabase.instance.client;
  static final _tableName = 'categories';

  static Future<List<CategoryModel>> fetchCategories() async {
    final response = await _client.from(_tableName).select();
    return (response as List)
        .map((e) => CategoryModel.fromMap(e))
        .toList();
  }

  static Future<void> addCategory(String name) async {
    await _client.from(_tableName).insert({'name': name});
  }

  static Future<void> deleteCategory(String id) async {
    await _client.from(_tableName).delete().eq('id', id);
  }
}
