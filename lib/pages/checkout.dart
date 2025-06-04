import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../supabase_config.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<dynamic> cartItems = [];
  int totalHarga = 0;
  int ongkir = 10000;
  String selectedMetode = 'Transfer Bank';

  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _hpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final response = await supabase
        .from('cart_items')
        .select('*, products(*)')
        .eq('user_id', user.id);

    int total = 0;
    for (var item in response) {
      final harga = (item['products']['price'] ?? 0) as num;
      final qty = (item['quantity'] ?? 1) as num;
      total += harga.toInt() * qty.toInt();
    }

    setState(() {
      cartItems = response;
      totalHarga = total;
    });
  }

  String formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return formatter.format(amount);
  }

  Future<void> updateQuantity(int index, int change) async {
    final item = cartItems[index];
    int newQty = (item['quantity'] ?? 1) + change;
    if (newQty < 1) return;

    await supabase
        .from('cart_items')
        .update({'quantity': newQty})
        .eq('id', item['id']);

    fetchCartItems();
  }

  Future<void> removeItem(int index) async {
    final item = cartItems[index];
    await supabase.from('cart_items').delete().eq('id', item['id']);
    fetchCartItems();
  }

  Future<void> handleCheckout() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    if (_namaController.text.isEmpty ||
        _alamatController.text.isEmpty ||
        _hpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi semua data pengiriman")),
      );
      return;
    }

    final totalBayar = totalHarga + ongkir;

    final orderResponse =
        await supabase
            .from('orders')
            .insert({
              'user_id': user.id,
              'total_amount': totalBayar,
              'status': 'Menunggu Pembayaran',
              'payment_method': selectedMetode,
            })
            .select()
            .single();

    final orderId = orderResponse['id'];

    for (var item in cartItems) {
      await supabase.from('order_items').insert({
        'order_id': orderId,
        'product_id': item['product_id'],
        'quantity': item['quantity'],
        'price': item['products']['price'],
      });
    }

    await supabase.from('shipping_info').insert({
      'order_id': orderId,
      'name': _namaController.text,
      'address': _alamatController.text,
      'phone': _hpController.text,
    });

    await supabase.from('cart_items').delete().eq('user_id', user.id);

    if (!mounted) return;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Checkout Berhasil"),
            content: const Text("Pesanan Anda telah dibuat."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/invoice');
                },
                child: const Text("Lihat Invoice"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body:
          cartItems.isEmpty
              ? const Center(child: Text("Keranjang kosong"))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Produk dalam Keranjang",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        final product = item['products'];

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: Image.network(
                              product['image_url'] ?? '',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      const Icon(Icons.image),
                            ),
                            title: Text(product['name'] ?? ''),
                            subtitle: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () => updateQuantity(index, -1),
                                ),
                                Text("${item['quantity']}"),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => updateQuantity(index, 1),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => removeItem(index),
                                ),
                              ],
                            ),
                            trailing: Text(
                              formatCurrency(product['price']),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),
                    const Text(
                      "Informasi Pengiriman",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _namaController,
                      decoration: const InputDecoration(
                        labelText: "Nama Penerima",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _alamatController,
                      decoration: const InputDecoration(
                        labelText: "Alamat Lengkap",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _hpController,
                      decoration: const InputDecoration(
                        labelText: "No. HP",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Metode Pembayaran",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedMetode,
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          selectedMetode = value!;
                        });
                      },
                      items:
                          ['Transfer Bank', 'COD']
                              .map(
                                (method) => DropdownMenuItem(
                                  value: method,
                                  child: Text(method),
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Ringkasan Pembayaran",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    ListTile(
                      title: const Text("Subtotal"),
                      trailing: Text(formatCurrency(totalHarga)),
                    ),
                    ListTile(
                      title: const Text("Ongkir"),
                      trailing: Text(formatCurrency(ongkir)),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text(
                        "Total Bayar",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        formatCurrency(totalHarga + ongkir),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.payment),
                        onPressed: handleCheckout,
                        label: const Text("Bayar Sekarang"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
