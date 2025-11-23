import 'package:flutter/material.dart';
import '../utils/constants.dart';

class FridgeOverviewScreen extends StatelessWidget {
  // Named Route
  static const String routeName = '/fridge_overview';

  const FridgeOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Categories
    final List<Map<String, dynamic>> categories = [
      {'name': 'Vegetables', 'icon': Icons.eco, 'color': Colors.green},
      {'name': 'Dairy', 'icon': Icons.egg, 'color': Colors.yellow},
      {'name': 'Meat', 'icon': Icons.kebab_dining, 'color': Colors.red},
      {'name': 'Beverages', 'icon': Icons.local_drink, 'color': Colors.blue},
      {'name': 'Snacks', 'icon': Icons.cookie, 'color': Colors.orange},
      {'name': 'Others', 'icon': Icons.fastfood, 'color': Colors.grey},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fridge Content'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text('Categories', style: AppTextStyles.headerStyle),
            ),
            
            // REQUIREMENT: Responsiveness & Grid Layout
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                      onTap: () {
                        // Navigate to Category Detail (Screen 7 - Future work)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Opened ${categories[index]['name']}')),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            categories[index]['icon'],
                            size: 50,
                            color: categories[index]['color'],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            categories[index]['name'],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
