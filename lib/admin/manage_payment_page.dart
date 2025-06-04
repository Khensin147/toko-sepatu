import 'package:flutter/material.dart';
import 'package:mekki/controller/payment_controller.dart';
import 'package:mekki/model/payment_model.dart';

class ManagePaymentPage extends StatefulWidget {
  const ManagePaymentPage({super.key});

  @override
  State<ManagePaymentPage> createState() => _ManagePaymentPageState();
}

class _ManagePaymentPageState extends State<ManagePaymentPage> {
  List<PaymentModel> payments = [];

  @override
  void initState() {
    super.initState();
    fetchPayments();
  }

  Future<void> fetchPayments() async {
    final result = await PaymentController().getAllPayments();
    setState(() {
      payments = result;
    });
  }

  Future<void> confirmPayment(String id) async {
    await PaymentController().confirmPayment(id);
    fetchPayments(); // refresh list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Pembayaran')),
      body: ListView.builder(
        itemCount: payments.length,
        itemBuilder: (context, index) {
          final payment = payments[index];
          return Card(
            child: ListTile(
              title: Text('Metode: ${payment.paymentMethod}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order ID: ${payment.orderId}'),
                  Text('Tanggal Bayar: ${payment.paidAt?.toLocal()}'),
                  Text('Status: ${payment.confirmed ? 'Terkonfirmasi' : 'Menunggu'}'),
                ],
              ),
              trailing: !payment.confirmed
                  ? ElevatedButton(
                      onPressed: () => confirmPayment(payment.id),
                      child: const Text('Konfirmasi'),
                    )
                  : const Icon(Icons.check_circle, color: Colors.green),
            ),
          );
        },
      ),
    );
  }
}
