import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/user_model.dart';

class UserController {
  static final SupabaseClient supabase = Supabase.instance.client;

  static Future<List<UserModel>> getAllUsers() async {
    final response = await supabase.from('users').select();
    final data = response as List;
    return data.map((e) => UserModel.fromMap(e)).toList();
  }

  static Future<void> deleteUser(String id) async {
    final response = await supabase.from('users').delete().eq('id', id);
    if (response == null) {
      throw Exception('Gagal menghapus user');
    }
  }
}
