import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final String? selectedFilter;
  final Function(String) onFilterSelected;

  const FilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildHargaFilter(context),
              _buildFilterItem(context, 'UKURAN'),
              _buildFilterItem(context, 'DISKON'),
              _buildFilterItem(context, 'REKOMENDASI'),
            ],
          ),
        ),
      ),
    );
  }

  // Filter dropdown untuk HARGA
  Widget _buildHargaFilter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text(
            'HARGA',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
          onChanged: (value) {
            if (value != null) onFilterSelected(value);
          },
          items: const [
            DropdownMenuItem(value: 'termurah', child: Text('Mahal Ke Murah')),
            DropdownMenuItem(value: 'termahal', child: Text('Murah Ke Mahal')),
          ],
        ),
      ),
    );
  }

  // Dummy dropdown filter lainnya (belum aktif)
  Widget _buildFilterItem(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
