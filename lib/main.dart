import 'package:flutter/material.dart';
import 'package:mekki/admin/add_product_page.dart';
import 'package:mekki/admin/admin_dashboard_page.dart';
import 'package:mekki/admin/manage_order_page.dart';
import 'package:mekki/admin/manage_product_page.dart';
import 'package:mekki/admin/manage_user_page.dart';
import 'package:mekki/auth/login_page.dart';
import 'package:mekki/pages/cart_page.dart';
import 'package:mekki/pages/category/anak.dart';
import 'package:mekki/pages/category/pria.dart';
import 'package:mekki/pages/category/wanita.dart';
import 'package:mekki/pages/checkout.dart';
import 'package:mekki/pages/home_page.dart';
import 'package:mekki/pages/parment_page.dart';
import 'package:mekki/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSupabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginPage(),
        '/home': (_) => const HomePage(),
        '/pria': (context) => const PriaPage(),
        '/wanita': (context) => const WanitaPage(),
        '/anak': (context) => const AnakPage(),
        '/payment': (context) => const PaymentPage(totalAmount: 0),
        '/checkout': (context) => const CheckoutPage(),
        '/cart': (context) => const CartPage(),
        '/admin/dashboard': (context) => const AdminDashboardPage(),
        '/admin/add-product': (context) => const AddProductPage(),
        '/admin/manage-products': (context) => const ManageProductPage(),
        '/admin/manage-orders': (context) => const ManageOrderPage(),
        '/admin/manage-users': (context) => const ManageUserPage(),
      },
    );
  }
}
