import 'package:flutter/material.dart';
import 'package:mekki/controller/admin_dashboard_controller.dart';
import 'package:mekki/widgets/admin_stat_card.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  final controller = AdminDashboardController();
  int userCount = 0;
  int productCount = 0;
  int orderCount = 0;

  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  Future<void> fetchStats() async {
    final users = await controller.getUserCount();
    final products = await controller.getProductCount();
    final orders = await controller.getOrderCount();

    setState(() {
      userCount = users;
      productCount = products;
      orderCount = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                AdminStatCard(
                  title: 'Total Users',
                  count: userCount,
                  icon: Icons.person,
                  color: Colors.blue,
                ),
                AdminStatCard(
                  title: 'Total Products',
                  count: productCount,
                  icon: Icons.shopping_bag,
                  color: Colors.green,
                ),
                AdminStatCard(
                  title: 'Total Orders',
                  count: orderCount,
                  icon: Icons.receipt_long,
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Aksi Cepat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/admin/add-product');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah Produk'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/admin/manage-products');
                  },
                  icon: const Icon(Icons.inventory),
                  label: const Text('Kelola Produk'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/admin/manage-orders');
                  },
                  icon: const Icon(Icons.list_alt),
                  label: const Text('Kelola Pesanan'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/admin/manage-users');
                  },
                  icon: const Icon(Icons.people),
                  label: const Text('Kelola Pengguna'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
