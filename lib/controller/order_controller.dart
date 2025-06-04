import 'package:mekki/model/ordel_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class OrderController {
  final supabase = Supabase.instance.client;

  Future<List<OrderModel>> fetchOrders() async {
    final response = await supabase
        .from('orders')
        .select()
        .order('created_at', ascending: false);

    final data = response as List;
    return data.map((item) => OrderModel.fromMap(item)).toList();
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await supabase
        .from('orders')
        .update({'status': status})
        .eq('id', orderId);
  }

  Future<void> deleteOrder(String orderId) async {
    await supabase
        .from('orders')
        .delete()
        .eq('id', orderId);
  }

  getAllOrders() {}
}
