import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  static Future<void> init() async {
    // Inisialisasi kunci publishable Stripe
    Stripe.publishableKey =
        'pk_test_51RXwZS2cn86kEenLv8Kmyll6cOw8vT5rDaJQEmsTnvEC4SyrzQxQru8BHMtCB0Bzul9aDuQ2VLDeffJa2DCeGhnh00Sa2CyXIy';

    await Stripe.instance.applySettings();
  }

  /// Fungsi placeholder — nanti akan dihubungkan dengan backend
  static Future<void> makePayment({
    required int amount,
    required String currency,
  }) async {
    // TODO: Hubungkan dengan backend (Supabase Edge Function / Node.js)
    throw UnimplementedError(
      'Fungsi pembayaran belum diimplementasikan. Harus menggunakan backend server untuk membuat Payment Intent.',
    );
  }
}
