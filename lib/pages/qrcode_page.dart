// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class QRCodePage extends StatelessWidget {
//   final String orderId;

//   const QRCodePage({Key? key, required this.orderId}) : super(key: key);

//   String get invoiceUrl {
//     // Gunakan IP LAN saat testing dari HP (ganti localhost)
//     return 'http://localhost:8080/invoice?id=$orderId';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Scan QR untuk Pembayaran"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             QrImageView(
//               data: invoiceUrl,
//               version: QrVersions.auto,
//               size: 250.0,
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Scan QR ini untuk melanjutkan ke Invoice',
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 10),
//             SelectableText(invoiceUrl),
//           ],
//         ),
//       ),
//     );
//   }
// }
