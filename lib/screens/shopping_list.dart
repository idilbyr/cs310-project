
import 'package:flutter/material.dart';

// ==========================================
// 4. SHOPPING LIST SCREEN
// ==========================================
class ShoppingListScreen extends StatefulWidget {
  static const String routeName = '/shopping_list';
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final List<String> items = ["Milk", "Chocolate", "Mushroom", "Orange", "Salmon"];
  final Set<String> checkedItems = {};

  void _onItemChecked(String item, bool? isChecked) {
    if (isChecked == true) {
      setState(() {
        checkedItems.add(item);
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            items.remove(item);
            checkedItems.remove(item);
          });
        }
      });
    }
  }

  void _clearAll() {
    setState(() {
      items.clear();
      checkedItems.clear();
    });
  }

  void _addItem() {
    setState(() {
      items.add("New Item ${items.length + 1}");
    });
  }

  @override
  Widget build(BuildContext context) {
    const purpleTheme = Color(0xFF7E57C2);

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
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isChecked = checkedItems.contains(item);
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
                            item,
                            style: TextStyle(
                              fontSize: 16,
                              decoration: isChecked ? TextDecoration.lineThrough : null,
                              color: isChecked ? Colors.grey : Colors.black87,
                            ),
                          ),
                        ],
                      ),
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