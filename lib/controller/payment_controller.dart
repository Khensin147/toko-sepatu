import 'package:mekki/model/payment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class PaymentController {
  final supabase = Supabase.instance.client;
  final String tableName = 'payments';

  Future<List<PaymentModel>> getAllPayments() async {
    final response = await supabase
        .from(tableName)
        .select()
        .order('paid_at', ascending: false);

    return (response as List)
        .map((map) => PaymentModel.fromMap(map))
        .toList();
  }

  Future<void> confirmPayment(String id) async {
    await supabase.from(tableName).update({
      'confirmed': true,
    }).eq('id', id);
  }
}
