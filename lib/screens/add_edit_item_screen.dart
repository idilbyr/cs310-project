import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'add_item_screen.dart';
import 'expiring_soon_screen.dart';
import '../services/firestore_services.dart';
import '../models/food_model.dart';
import 'fridge_overview_screen.dart';
import '../providers/fridge_provider.dart';

class AddEditHomeScreen extends StatelessWidget {
  static const routeName = '/add_edit_item';


  const AddEditHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final fridgeProvider = Provider.of<FridgeProvider>(context);
    final fridgeId = fridgeProvider.selectedFridge?.id;
    final fridgeName = fridgeProvider.selectedFridge?.name ?? "My Fridge";

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        elevation: 0,
        title: const Text(
          "Add / Edit Item",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.account_circle, size: 28),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fridgeName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6750A4), // trying this purple color
              ),
            ),
            const SizedBox(height: 4),

            // Total Items count
            StreamBuilder<List<FoodModel>>(
              stream: fridgeId != null
                  ? FirestoreService().getFoodsForFridge(fridgeId)
                  : (user != null
                  ? FirestoreService().getFoods(user.uid)
                  : const Stream.empty()),
              builder: (context, snapshot) {
                final count = snapshot.data?.length ?? 0;
                return Text(
                  "Total Items: $count",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // Add Item Button
            _buildMainButton(
              context,
              label: "Add Item",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddItemScreen(fridgeId: fridgeId),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Edit Item Button
            _buildMainButton(
              context,
              label: "Edit Item",
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select an item from the fridge list to edit.'),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Expiring Soon Button
            _buildMainButton(
              context,
              label: "Expiring Soon List",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExpiringSoonScreen(fridgeId: fridgeId),
                  ),
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