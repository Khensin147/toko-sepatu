import 'package:flutter/material.dart';
import 'package:mekki/auth/signup.dart'; // Ini akan tetap terpakai untuk navigasi kembali ke SignUpPage jika ada kasus rekursif (meskipun tidak ideal)
import 'package:mekki/widgets/footer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mekki/pages/home_page.dart'; // Tambahkan ini jika HomePage akan diakses setelah login sukses dari SignUp
import 'package:mekki/admin/admin_dashboard_page.dart'; // Tambahkan ini jika AdminDashboardPage akan diakses setelah login sukses dari SignUp

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  bool _isPasswordVisible = false; // State untuk toggle visibility password

  Future<void> _signup() async {
    setState(() => _loading = true);
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final fullName = _nameController.text.trim();
      final phone = _phoneController.text.trim();

      // Mendaftar user ke Supabase
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Simpan nama dan telepon ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('full_name', fullName);
        await prefs.setString('phone', phone);

        // Tampilkan dialog bahwa verifikasi email diperlukan
        if (!mounted) return;
        // Menggunakan AlertDialog custom untuk menghindari alert()
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text("Konfirmasi Email"),
              content: const Text(
                "Kami telah mengirim email verifikasi ke alamat kamu. "
                "Silakan cek email dan klik link verifikasi sebelum login.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Tutup dialog
                    Navigator.pop(context); // Kembali ke halaman login
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        throw const AuthException("Sign up failed. User ID is null.");
      }
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Auth error: ${e.message}")));
      }
    } on PostgrestException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Database error: ${e.message}")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error tidak diketahui: $e")));
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          'https://brandlogovector.com/wp-content/uploads/2021/07/Adidas-Logo.png', // Placeholder untuk logo Adidas
          height: 40,
          errorBuilder:
              (context, error, stackTrace) =>
                  const SizedBox.shrink(), // Mengembalikan widget kosong
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0, // Tanpa bayangan
        automaticallyImplyLeading:
            false, // Sembunyikan tombol kembali jika tidak diperlukan
      ),
      body: SingleChildScrollView(
        child: Column(
          // Menggunakan Column untuk menampung konten atas dan footer
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1000,
                  ), // Atur lebar maksimum
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Kolom Kiri: Formulir Pendaftaran
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'BUAT AKUN',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Sangat mudah. Buat Akun Anda Hanya perlu Memasukan Seperti :',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: "Nama Lengkap",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                labelText: "Nomor Telepon",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: "Kata Sandi",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: _loading ? null : _signup,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child:
                                  _loading
                                      ? const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      )
                                      : const Text(
                                        "REGISTRASI →",
                                        style: TextStyle(fontSize: 18),
                                      ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Dengan Registrasi, Anda menyetujui Syarat & Ketentuan serta Kebijakan Privasi yang berlaku',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              'ATAU',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            OutlinedButton.icon(
                              onPressed: () {
                                // TODO: Implementasi pendaftaran Google
                              },
                              icon: Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
                                height: 24,
                                width: 24,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const SizedBox.shrink(),
                              ),
                              label: const Text('GOOGLE'),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            OutlinedButton.icon(
                              onPressed: () {
                                // TODO: Implementasi pendaftaran Apple
                              },
                              icon: Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/f/fa/Apple_logo_black.svg',
                                height: 24,
                                width: 24,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const SizedBox.shrink(),
                              ),
                              label: const Text('facnuk'),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Bagian TextButton "Sudah punya akun? Masuk" telah dihapus di sini
                          ],
                        ),
                      ),
                      const SizedBox(width: 40), // Spasi antara dua kolom
                      // Kolom Kanan: Manfaat membuat akun (mirip dengan bagian "BUAT AKUN" di Login Page)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'MENGAPA MEMBUAT AKUN?',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Dengan membuat akun, Anda Bisa Mengakses :',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildBenefitRow('Akses Ke Halaman Utama.'),
                            _buildBenefitRow('Akses Menu Detail Sepatu.'),
                            _buildBenefitRow('Akses Ke Keranjang.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const FooterWidget(), // FooterWidget di luar ConstrainedBox untuk full width
          ],
        ),
      ),
    );
  }

  // Widget pembantu untuk baris manfaat
  Widget _buildBenefitRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, color: Colors.black, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
