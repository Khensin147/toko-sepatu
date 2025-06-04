import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  final VoidCallback? onAboutTap;

  const CustomNavbar({super.key, this.onAboutTap});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '/';

    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TOKOSEPATU',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1.5,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.black),
                        onPressed: () {},
                      ),
                      IconButton(
                        iconSize: 30,
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/cart');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _navItem(context, 'Home', '/home', currentRoute),
                _navItem(context, 'Pria', '/pria', currentRoute),
                _navItem(context, 'Wanita', '/wanita', currentRoute),
                _navItem(context, 'Anak', '/anak', currentRoute),
                _aboutItem(context, currentRoute),
                _navItem(context, 'Contact', '/contact', currentRoute),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    String label,
    String route,
    String currentRoute,
  ) {
    final isActive = currentRoute == route;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () {
          if (!isActive) {
            Navigator.pushNamed(context, route);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            if (isActive) Container(height: 2, width: 20, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _aboutItem(BuildContext context, String currentRoute) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () {
          if (currentRoute == '/' || currentRoute == '/home') {
            onAboutTap?.call();
          } else {
            Navigator.pushNamed(
              context,
              '/home',
              arguments: {'scrollTo': 'about'}, // ✅ Dikirim dalam Map
            );
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'ABOUT',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
