
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_services.dart';
import '../models/shopping_item_model.dart';

// ==========================================
// 4. SHOPPING LIST SCREEN
// ==========================================
class ShoppingListScreen extends StatefulWidget {
  static const String routeName = '/shopping_list';
  final String? fridgeId;
  
  const ShoppingListScreen({super.key, this.fridgeId});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  User? get currentUser => FirebaseAuth.instance.currentUser;

  void _onItemChecked(ShoppingItemModel item, bool? isChecked) {
    if (currentUser == null) return;

    if (isChecked == true) {
      _firestoreService.toggleShoppingItem(item.id, true);
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _firestoreService.deleteShoppingItem(item.id);
        }
      });
    } else {
      _firestoreService.toggleShoppingItem(item.id, false);
    }
  }

  void _clearAll() {
    if (currentUser == null) return;
    _firestoreService.clearShoppingList(currentUser!.uid, fridgeId: widget.fridgeId);
  }

  void _addItem() {
    showDialog(
      context: context,
      builder: (context) {
        String newItem = "";
        return AlertDialog(
          title: const Text("Add Item"),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: "Enter item name"),
            onChanged: (value) {
              newItem = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (newItem.trim().isNotEmpty && currentUser != null) {
                  _firestoreService.addShoppingItem(
                    newItem.trim(), 
                    currentUser!.uid,
                    fridgeId: widget.fridgeId
                  );
                }
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const purpleTheme = Color(0xFF7E57C2);
    final user = currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Please login to view shopping list")),
      );
    }

    return Scaffold(
      // backgroundColor removed
      appBar: AppBar(
        // backgroundColor removed
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Removed hardcoded color
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  decoration: BoxDecoration(
                    color: purpleTheme,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "SHOPPING LIST",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: StreamBuilder<List<ShoppingItemModel>>(
                  stream: _firestoreService.getShoppingList(user.uid, fridgeId: widget.fridgeId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final items = snapshot.data ?? [];

                    if (items.isEmpty) {
                      return const Center(child: Text("No items in shopping list"));
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final isChecked = item.isChecked;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  value: isChecked,
                                  activeColor: purpleTheme,
                                  side: const BorderSide(color: purpleTheme, width: 1.5),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  onChanged: (val) => _onItemChecked(item, val),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  decoration: isChecked ? TextDecoration.lineThrough : null,
                                  color: isChecked ? Colors.grey : Theme.of(context).textTheme.bodyLarge?.color,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 30,
            child: Column(
              children: [
                InkWell(
                  onTap: _addItem,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blueAccent, width: 2),
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.add, color: Colors.blueAccent, size: 30),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: _clearAll,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF607D8B),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white, size: 24),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

