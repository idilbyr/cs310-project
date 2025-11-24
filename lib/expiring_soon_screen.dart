import 'package:flutter/material.dart';
import 'assets/item_data.dart';
import 'add_edit_item_screen.dart';

class ExpiringSoonScreen extends StatelessWidget {
  const ExpiringSoonScreen({super.key});

  // temporary
  List<FridgeItem> getDummyItems() {
    return [
      FridgeItem("Milk", "1L", "Pınar", "1 day", "Dairy product"),
      FridgeItem("Chicken", "500g", "Banvit", "2 days", "Store in freezer"),
      FridgeItem("Apples", "4 pcs", "Local", "3 days", "Organic apples"),
      FridgeItem("Yogurt", "2 cups", "Sütaş", "4 days", "Low-fat"),
      FridgeItem("Carrots", "1kg", "Organic", "5 days", "Fresh batch"),
    ];
  }

  Color getCardColor(int daysLeft) {
    if (daysLeft <= 1) return const Color(0xFFFF8A80); // red
    if (daysLeft <= 3) return const Color(0xFFFFE082); // orange
    return const Color(0xFFFFF59D); // yellow
  }

  @override
  Widget build(BuildContext context) {
    final items = getDummyItems();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {},
        ),
        title: const Text(
          "Expiring Soon List",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // back to add-edit
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddEditHomeScreen()),
                );
              },
              icon: const Icon(Icons.arrow_back, size: 18, color: Colors.blue),
              label: const Text(
                "Back to Add / Edit",
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
            const SizedBox(height: 4),

            const Text(
              "Fridge 1",
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
                color: const Color(0xFFD1C4E9), // light purple
                borderRadius: BorderRadius.circular(25),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.black54),
                  hintText: "Search for items",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
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
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final daysLeft = int.tryParse(item.exp.split(" ")[0]) ?? 0;
                  final color = getCardColor(daysLeft);

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
                          Text("Amount: ${item.amount}",
                              style: const TextStyle(color: Colors.black87)),
                          Text("Brand: ${item.brand}",
                              style: const TextStyle(color: Colors.black87)),
                          Text("Expiring in: ${item.exp}",
                              style: const TextStyle(color: Colors.black87)),
                          if (item.notes.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text("Notes: ${item.notes}",
                                style: const TextStyle(color: Colors.black87)),
                          ],
                          const SizedBox(height: 6),
                          LinearProgressIndicator(
                            value: 1 - (daysLeft / 5),
                            color: Colors.redAccent,
                            backgroundColor: Colors.white,
                            minHeight: 6,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.delete, color: Colors.black87),
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
