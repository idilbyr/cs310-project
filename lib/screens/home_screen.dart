import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'create_fridge_screen.dart';
import 'fridge_overview_screen.dart';

class HomeScreen extends StatelessWidget {
  // Named Route
  static const String routeName = '/home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data: List of fridges the user belongs to
    final List<Map<String, String>> myFridges = [
      {'name': 'Home Fridge', 'role': 'Owner'},
      {'name': 'Office Kitchen', 'role': 'Member'},
      {'name': 'Picnic Cooler', 'role': 'Admin'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Fridges'),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false, // Don't show back button on Home
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to Settings (future implementation)
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome Back!', style: AppTextStyles.headerStyle),
            const SizedBox(height: 10),
            const Text('Select a fridge to manage your items:', style: AppTextStyles.bodyStyle),
            const SizedBox(height: 20),

            // REQUIREMENT: List & Cards
            Expanded(
              child: ListView.builder(
                itemCount: myFridges.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.accentColor,
                        child: const Icon(Icons.kitchen, color: Colors.white),
                      ),
                      title: Text(myFridges[index]['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(myFridges[index]['role']!),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Navigate to Fridge Overview (Screen 6)
                        Navigator.pushNamed(context, FridgeOverviewScreen.routeName);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // REQUIREMENT: Buttons for "Create" and "Join"
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'join',
            onPressed: () {
              // Navigate to Join Screen (Screen 5 - Future work)
            },
            label: const Text('Join'),
            icon: const Icon(Icons.link),
            backgroundColor: Colors.blueGrey,
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            heroTag: 'create',
            onPressed: () {
              // Navigate to Create Fridge (Screen 4)
              Navigator.pushNamed(context, CreateFridgeScreen.routeName);
            },
            label: const Text('Create New'),
            icon: const Icon(Icons.add),
            backgroundColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
