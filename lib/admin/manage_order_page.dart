import 'package:flutter/material.dart';
import 'package:mekki/controller/order_controller.dart';
import 'package:mekki/model/ordel_model.dart';

class ManageOrderPage extends StatefulWidget {
  const ManageOrderPage({super.key});

  @override
  State<ManageOrderPage> createState() => _ManageOrderPageState();
}

class _ManageOrderPageState extends State<ManageOrderPage> {
  List<OrderModel> orders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final result = await OrderController().getAllOrders();
    setState(() {
      orders = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Pesanan')),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            child: ListTile(
              title: Text('Order ID: ${order.id}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('User: ${order.userId}'),
                  Text('Total: Rp${order.total.toStringAsFixed(0)}'),
                  Text('Status: ${order.status}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
