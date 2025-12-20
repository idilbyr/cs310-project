import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/food_model.dart';
import '../services/firestore_services.dart';
import 'add_edit_item_screen.dart';
//NOTE: since the calculation of the color base on time, i am changing the logichere.
// Now the colors are base on certain day ranges than percentages
// 0-3 days -> red
// 4-7 days -> orange
// 8-15 days -> yellow
// 16+ days -> green

class ExpiringSoonScreen extends StatefulWidget {
  static const routeName = '/expiring_soon';
  final String? fridgeId;

  const ExpiringSoonScreen({super.key, this.fridgeId});

  @override
  State<ExpiringSoonScreen> createState() => _ExpiringSoonScreenState();
}

class _ExpiringSoonScreenState extends State<ExpiringSoonScreen> {
  String _searchText = "";

  Color getCardColor(int daysLeft) {
    if (daysLeft <= 3) return const Color(0xFFffcdd2); // Red 100
    if (daysLeft <= 7) return const Color(0xFFffe0b2); // Orange 100
    if (daysLeft <= 15) return const Color(0xFFfff9c4); // Yellow 100
    return const Color(0xFFc8e6c9); // Green 100
  }

  double calculatePercentage(DateTime createdAt, DateTime expirationDate) {
    final now = DateTime.now();
    final totalLifetime = expirationDate.difference(createdAt).inMinutes;
    final elapsed = now.difference(createdAt).inMinutes;

    if (totalLifetime <= 0) return 100.0; // Avoid division by zero, treat as expired/urgent
    
    double pct = (elapsed / totalLifetime) * 100;
    return pct.clamp(0.0, 100.0);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text("Please log in")));
    }

    return Scaffold(
      // backgroundColor removed
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Changed to arrow_back
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Expiring Soon List",
          style: TextStyle(fontWeight: FontWeight.bold), // Removed color
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle), // Removed color
            onPressed: () {},
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),

            const Text(
              "Fridge Items",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Items close to expire:",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 15),

            // search bar
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : const Color(0xFFD1C4E9),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchText = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                  hintText: "Search for items",
                  hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "List of Items",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),

            // item list
            Expanded(
              child: StreamBuilder<List<FoodModel>>(
                stream: widget.fridgeId != null
                    ? FirestoreService().getFoodsForFridge(widget.fridgeId!)
                    : FirestoreService().getFoods(user.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  final allFoods = snapshot.data ?? [];
                  
                  // Filter by search text
                  final filteredFoods = allFoods.where((food) {
                    return food.name.toLowerCase().contains(_searchText);
                  }).toList();
                  // sort base on the expiration date
                  filteredFoods.sort((a, b) => a.expirationDate.compareTo(b.expirationDate));

                  if (filteredFoods.isEmpty) {
                    return const Center(child: Text("No items found"));
                  }

                  return ListView.builder(
                    itemCount: filteredFoods.length,
                    itemBuilder: (context, index) {
                      final item = filteredFoods[index];
                      final percentage = calculatePercentage(item.createdAt.toDate(), item.expirationDate);
                      final daysLeft = item.expirationDate.difference(DateTime.now()).inDays;
                      final color = getCardColor(daysLeft);
                      
                      final daysLeftText = daysLeft < 0 
                          ? "Expired ${daysLeft.abs()} days ago" 
                          : (daysLeft == 0 ? "Expires Today" : "$daysLeft days left");

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          title: Text(
                            "Item name: ${item.name}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Amount: ${item.amount} ${item.unit}",
                                  style: const TextStyle(color: Colors.black87)),
                              Text("Brand: ${item.brand}",
                                  style: const TextStyle(color: Colors.black87)),
                              Text("Status: $daysLeftText",
                                  style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                              if (item.notes.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text("Notes: ${item.notes}",
                                    style: const TextStyle(color: Colors.black87)),
                              ],
                              const SizedBox(height: 6),
                              LinearProgressIndicator(
                                value: percentage / 100,
                                color: Colors.redAccent,
                                backgroundColor: Colors.white.withOpacity(0.5),
                                minHeight: 6,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.black87),
                            onPressed: () async {
                               await FirestoreService().deleteFood(item.id);
                            },
                          ),
                        ),
                      );
                    },
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
