import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  // Widget pembantu untuk membangun setiap kartu kontak
  Widget _buildContactCard({
    required IconData icon,
    required String description,
    required String buttonText, // Teks ini akan menjadi detail kontak
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: Card(
        color: Colors.white, // Background kartu putih
        elevation: 0, // Tidak ada bayangan untuk tampilan datar
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Sudut membulat
          side: BorderSide(
            color: Colors.white!,
            width: 1,
          ), // Border abu-abu tipis
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10), // Spasi antar kartu
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.black, // Warna ikon hitam
                size: 48,
              ),
              const SizedBox(height: 15),
              // Menghapus Text(title) di sini sesuai permintaan "hapus kata katanya"
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700], // Warna teks deskripsi abu-abu gelap
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: onPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black, // Warna teks tombol hitam
                  side: const BorderSide(
                    color: Colors.black,
                  ), // Border tombol hitam
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ), // Sudut tombol membulat
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  buttonText,
                ), // Ini akan menampilkan nomor telepon/email/nama Facebook
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(
        0xFFF5F6F7,
      ), // Background diubah agar sesuai dengan halaman di atasnya
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 60,
      ), // Padding di sekitar konten
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan konten kolom
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32, // Ukuran font lebih besar untuk judul utama
              color: Colors.black, // Warna teks hitam
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Please reach out to us if you have any questions regarding sales, support, or general questions.',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),

          // Baris kartu kontak (Telepon, Email, Facebook)
          LayoutBuilder(
            builder: (context, constraints) {
              // Menentukan apakah akan menampilkan dalam satu kolom atau tiga kolom
              if (constraints.maxWidth > 700) {
                // Lebar cukup untuk 3 kolom
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContactCard(
                      icon: Icons.call, // Ikon telepon
                      description:
                          'Hubungi kami langsung untuk bantuan cepat dan informasi.', // Deskripsi disesuaikan
                      buttonText:
                          '+62 812-3456-7890', // Nomor telepon langsung di tombol
                      onPressed: () {
                        // TODO: Implementasi aksi Telepon Kami (launchUrl for tel:)
                        print('Call Us: +62 812-3456-7890');
                      },
                    ),
                    _buildContactCard(
                      icon: Icons.email, // Ikon email
                      description:
                          'Kirimkan pertanyaan atau umpan balik Anda melalui email.', // Deskripsi disesuaikan
                      buttonText:
                          'titit@gmail.com', // Alamat email langsung di tombol
                      onPressed: () {
                        // TODO: Implementasi aksi Kirim Email (launchUrl for mailto:)
                        print('Send Email to: titit@gmail.com');
                      },
                    ),
                    _buildContactCard(
                      icon: Icons.facebook, // Ikon Facebook
                      description:
                          'Ikuti kami di Facebook untuk pembaruan, berita, dan komunitas.', // Deskripsi disesuaikan
                      buttonText:
                          'Mekki Official Facebook Page', // Teks yang lebih menarik di tombol
                      onPressed: () {
                        // TODO: Implementasi aksi Kunjungi Facebook (launchUrl for FB page)
                        print('Visit Facebook Page');
                      },
                    ),
                  ],
                );
              } else {
                // Lebar kurang, tampilkan dalam satu kolom
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildContactCard(
                      icon: Icons.call,
                      description:
                          'Hubungi kami langsung untuk bantuan cepat dan informasi.',
                      buttonText: '+62 812-3456-7890',
                      onPressed: () {
                        print('Call Us: +62 812-3456-7890');
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ), // Spasi antar kartu dalam mode kolom
                    _buildContactCard(
                      icon: Icons.email,
                      description:
                          'Kirimkan pertanyaan atau umpan balik Anda melalui email.',
                      buttonText: 'titit@gmail.com',
                      onPressed: () {
                        print('Send Email to: titit@gmail.com');
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildContactCard(
                      icon: Icons.facebook,
                      description:
                          'Ikuti kami di Facebook untuk pembaruan, berita, dan komunitas.',
                      buttonText: 'Mekki Official Facebook Page',
                      onPressed: () {
                        print('Visit Facebook Page');
                      },
                    ),
                  ],
                );
              }
            },
          ),
          const SizedBox(
            height: 60,
          ), // Memberi ruang di bawah kartu sebelum akhir footer
        ],
      ),
    );
  }
}
