import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final int totalAmount;

  const PaymentPage({super.key, required this.totalAmount});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = 'Transfer Bank';

  final List<String> paymentMethods = [
    'Transfer Bank',
    'E-Wallet (OVO, GoPay, DANA)',
    'Kartu Kredit',
    'Bayar di Tempat (COD)',
  ];

  void _handlePayment() {
    // TODO: Tambahkan logika simpan data pembayaran ke Supabase

    // Arahkan ke halaman invoice setelah pembayaran
    Navigator.pushNamed(context, '/invoice');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Metode Pembayaran', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Dropdown metode pembayaran
            DropdownButtonFormField<String>(
              value: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
              items: paymentMethods.map((method) {
                return DropdownMenuItem(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Pilih Metode Pembayaran',
              ),
            ),

            const SizedBox(height: 24),
            Text('Total yang harus dibayar:', style: TextStyle(fontSize: 16)),
            Text(
              'Rp ${widget.totalAmount}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const Spacer(),

            // Tombol Bayar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handlePayment,
                child: const Text('Bayar Sekarang'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
