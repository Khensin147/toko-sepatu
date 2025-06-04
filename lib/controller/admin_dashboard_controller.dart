import 'package:supabase_flutter/supabase_flutter.dart';

class AdminDashboardController {
  final supabase = Supabase.instance.client;

  Future<int> getUserCount() async {
    final res = await supabase.from('users').select('id');
    return res.length;
  }

  Future<int> getProductCount() async {
    final res = await supabase.from('products').select('id');
    return res.length;
  }

  Future<int> getOrderCount() async {
    final res = await supabase.from('orders').select('id');
    return res.length;
  }
}
