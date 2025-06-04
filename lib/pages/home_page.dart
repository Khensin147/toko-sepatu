import 'package:flutter/material.dart';
import 'package:mekki/widgets/about_section.dart';
import 'package:mekki/widgets/footer_widget.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/best_products_section.dart';

final GlobalKey aboutKey = GlobalKey();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  void scrollToAbout() {
    final context = aboutKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is Map && args['scrollTo'] == 'about') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToAbout();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomNavbar(onAboutTap: scrollToAbout),
          const Divider(height: 1, color: Colors.black12, thickness: 1),
          Expanded(
            child: ListView(
              controller: _scrollController,
              primary: false,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset('assets/gege.jpg', fit: BoxFit.cover),
                      Container(color: Colors.black.withOpacity(0.3)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "FASHION",
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                "MADE",
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                              ),
                              const Text(
                                "SIMPLE.",
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 24),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/products');
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.white),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 16,
                                  ),
                                ),
                                child: const Text(
                                  "SHOP NOW",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                BestProductsSection(),
                AboutSection(key: aboutKey),
               const FooterWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
