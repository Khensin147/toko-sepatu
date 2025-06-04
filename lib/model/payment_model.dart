class PaymentModel {
  final String id;
  final String orderId;
  final String paymentMethod;
  final DateTime? paidAt;
  final bool confirmed;

  PaymentModel({
    required this.id,
    required this.orderId,
    required this.paymentMethod,
    this.paidAt,
    required this.confirmed,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'],
      orderId: map['order_id'],
      paymentMethod: map['payment_method'] ?? '',
      paidAt: map['paid_at'] != null ? DateTime.parse(map['paid_at']) : null,
      confirmed: map['confirmed'] ?? false,
    );
  }
}
