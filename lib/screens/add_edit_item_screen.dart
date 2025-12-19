import 'package:flutter/material.dart';
import 'package:fridge_note/screens/fridge_overview_screen.dart';
import 'add_item_screen.dart';
import 'edit_item_screen.dart';
import 'expiring_soon_screen.dart';
import 'detailed_category_screen.dart';
import '../main.dart';

class AddEditHomeScreen extends StatelessWidget {
  static const routeName = '/add_edit_item';
  const AddEditHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Add / Edit Item",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.account_circle, color: Colors.black, size: 28),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // back to fridgemain
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FridgeOverviewScreen()),
                );
              },
              icon: const Icon(Icons.arrow_back, size: 18, color: Colors.blue),
              label: const Text(
                "Back to Fridge List",
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),

            const SizedBox(height: 8),

            // fridge title
            const Text(
              "Fridge 1",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),

            // total items
            const Text(
              "Total Items:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),

            // add item
            _buildMainButton(
              context,
              label: "Add Item",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddItemScreen()),
                );
              },
            ),
            const SizedBox(height: 20),

            // edit item
            _buildMainButton(
              context,
              label: "Edit Item",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditItemScreen()),
                );
              },
            ),
            const SizedBox(height: 20),

            // expring soon
            _buildMainButton(
              context,
              label: "Expiring Soon List",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExpiringSoonScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainButton(BuildContext context,
      {required String label, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8E7CC3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
