import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100], // Background abu-abu muda yang membentang penuh
      padding: const EdgeInsets.symmetric(
        vertical: 40,
      ), // Hanya padding vertikal di Container
      child: Center(
        // Memusatkan konten dalam Container
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1200, // Lebar maksimum untuk konten (sesuai gambar)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ), // Padding horizontal untuk konten di dalam ConstrainedBox
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Seluruh kolom ini rata kiri
              children: [
                // Baris pertama: Dua judul tebal
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'DAPATKAN KOLEKSI SEPATU OLAHRAGA, SNEAKER & PERLENGKAPAN OLAHRAGA TERBARU DI SHOES SHOP INDONESIA',
                        style: const TextStyle(
                          fontSize: 20, // Ukuran font diperbesar
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Colors.black, // Pastikan warna hitam
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 32,
                    ), // Spasi antar judul (disesuaikan)
                    Expanded(
                      child: Text(
                        'SHOES SHOP MENYEDIAKAN SEMUA KEBUTUHAN OLAHRAGA ANDA',
                        style: const TextStyle(
                          fontSize: 20, // Ukuran font diperbesar
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Colors.black, // Pastikan warna hitam
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ), // Spasi antara baris judul dan baris paragraf (disesuaikan)
                // Baris kedua: Dua paragraf deskriptif
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 15, // Ukuran font diperbesar sedikit
                            color: Colors.black,
                            height: 1.4, // Ketinggian baris sedikit disesuaikan
                          ),
                          children: [
                            TextSpan(
                              text:
                                  'Selamat datang di situs resmi SHOES SHOP di mana Anda dapat membeli perlengkapan dan aksesoris olahraga berkualitas. ',
                            ),
                            TextSpan(
                              text:
                                  'Toko Online Resmi SHOES SHOP menyediakan produk terbaik mulai dari sepatu olahraga, dan sneaker, hingga aksesoris olahraga lainnya untuk semua kebutuhan Anda. ',
                            ),
                            TextSpan(
                              text:
                                  'Tersedia berbagai macam sepatu yang cocok untuk setiap momen dan nyaman dipakai saat berolahraga. ',
                            ),
                            TextSpan(
                              text:
                                  'Di Toko Online Resmi KAMI, tersedia berbagai macam produk top seperti Sepatu Sepak Bola Ace & X, Originals, Sepatu Training, Atasan untuk Running, Sport Bra Wanita, Aksesoris Olahraga dan masih banyak lagi. ',
                            ),
                            TextSpan(
                              text:
                                  'Toko Online Resmi Kami terus memperbarui daftar produknya sehingga Anda dapat membeli koleksi sepatu, pakaian, aksesoris olahraga terbaru kami. ',
                            ),
                            TextSpan(
                              text:
                                  'Temukan sepatu favorit Anda mulai dari sepatu untuk pria, wanita, dan anak-anak hanya di toko online resmi kami.',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 32,
                    ), // Spasi antara kedua paragraf (disesuaikan)
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 15, // Ukuran font diperbesar sedikit
                            color: Colors.black,
                            height: 1.4, // Ketinggian baris sedikit disesuaikan
                          ),
                          children: [
                            TextSpan(
                              text:
                                  'Mencari perlengkapan olahraga yang dapat meningkatkan performa Anda dan lebih nyaman saat digunakan berolahraga? ',
                            ),
                            TextSpan(
                              text:
                                  'Hanya ada satu tempat yang dapat menyediakan semua kebutuhan olahraga Anda mulai dari sepatu hingga aksesoris, yaitu Toko Online Resmi SHOES SHOP. ',
                            ),
                            TextSpan(
                              text:
                                  'SHOES SHOP menyediakan perlengkapan olahraga mulai dari sepatu training, celana running, hingga aksesoris olahraga untuk pria, wanita, dan anak-anak. ',
                            ),
                            TextSpan(
                              text:
                                  'Toko Online Resmi kami menawarkan banyak deal untuk Anda yang berbelanja secara online; mulai dari gratis ongkos kirim jika Anda berbelanja minimal Rp 900.000, easy return, fast response, dan masih banyak lagi. ',
                            ),
                            TextSpan(
                              text:
                                  'Beli segera sepatu untuk segala jenis olahraga hanya di SHOES SHOP.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
