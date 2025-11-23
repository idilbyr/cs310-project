import 'package:flutter/material.dart';
import '../utils/constants.dart';

class FridgeOverviewScreen extends StatelessWidget {
  static const String routeName = '/fridge_overview';

  const FridgeOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FRIDGE_1', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Renkli Kategoriler Listesi
            Expanded(
              child: ListView(
                children: [
                  _buildCategoryCard('VEGETABLES', Icons.eco, const Color(0xFFFFE082)), // Sarı
                  _buildCategoryCard('MEATS', Icons.kebab_dining, const Color(0xFFFFCDD2)), // Pembe
                  _buildCategoryCard('FISH', Icons.set_meal, const Color(0xFF90CAF9)), // Mavi
                  _buildCategoryCard('FRUIT', Icons.apple, const Color(0xFFFFCC80)), // Turuncu
                  _buildCategoryCard('DAIRY', Icons.egg, const Color(0xFFFFF59D)), // Açık Sarı
                ],
              ),
            ),
            
            // Alt Butonlar
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Shopping List sayfasına git (Henüz yok)
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Shopping List'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Add / Edit Item'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Kart Tasarımı Yardımcı Fonksiyonu
  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        leading: Icon(icon, size: 40, color: Colors.black54),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
           // Detay sayfasına git
        },
      ),
    );
  }
}
