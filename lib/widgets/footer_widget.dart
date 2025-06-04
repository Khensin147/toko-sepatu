import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  Widget buildColumn(String title, List<String> items) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // rata kiri
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          for (var item in items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                item,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white, // background abu muda
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ====== Bagian Deskripsi ======
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          
                  ],
                ),

          const SizedBox(height: 40),

          // ====== Bagian Menu ======
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 40,
            runSpacing: 30,
            children: [
              SizedBox(
                width: 150,
                child: buildColumn('PRODUK', [
                  'Sepatu',
                  'Pakaian',
                  'Aksesoris',
                ]),
              ),
              SizedBox(
                width: 150,
                child: buildColumn('FEATURED', [
                  'New Arrivals',
                  'Impossible is Nothing',
                  'Sale',
                  'Last Chance',
                ]),
              ),
              SizedBox(
                width: 180,
                child: buildColumn('SPORT', [
                  'Predator Football Boots',
                  'X Football Boots',
                  'Copa Football Boots',
                  'Manchester United',
                  'Juventus',
                  'Real Madrid',
                  'Arsenal',
                  'Bayern Munchen',
                  'Boost Shoes',
                  'Ultraboost',
                ]),
              ),
              SizedBox(
                width: 150,
                child: buildColumn('KOLEKSI', [
                  'Stan Smith',
                  'Superstar',
                  'Ultraboost',
                  'NMD',
                  'adidas Exclusive',
                ]),
              ),
              SizedBox(
                width: 150,
                child: buildColumn('LEGAL', [
                  'Kebijakan Privasi',
                  'Syarat dan Ketentuan',
                  'Ketentuan Pengiriman',
                ]),
              ),
              SizedBox(
                width: 200,
                child: buildColumn('SUPPORT', [
                  'Hubungi Kami',
                  'Panduan Ukuran',
                  'Cara Berbelanja',
                  'Promo & Voucher',
                  'Pembayaran',
                  'Pengiriman',
                  'Retur dan Pengembalian Dana',
                  'Tentang Produk adidas',
                  'Cara Menggunakan Situs Kami',
                  'Akun Anda',
                  'Cek Status Pesanan',
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
