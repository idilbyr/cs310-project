import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/food_model.dart';
import '../services/firestore_services.dart';

class EditItemScreen extends StatefulWidget {
  static const routeName = '/edit_item';
  final FoodModel? food;
  final String? fridgeId;

  const EditItemScreen({super.key, this.food, this.fridgeId});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  // Edit Mode Variables
  late String selectedCategory;
  late String selectedUnit;
  late double amount;
  late DateTime selectedDate;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // Selection Mode Variables
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    if (widget.food != null) {
      _initializeEditMode(widget.food!);
    }
  }

  void _initializeEditMode(FoodModel food) {
    selectedCategory = food.category;
    selectedUnit = food.unit;
    amount = food.amount;
    selectedDate = food.expirationDate;
    nameController.text = food.name;
    brandController.text = food.brand;
    notesController.text = food.notes;
  }

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _saveItem() async {
    if (widget.food == null) return;
    try {
      await FirestoreService().updateFood(
        docId: widget.food!.id,
        name: nameController.text.trim(),
        category: selectedCategory,
        brand: brandController.text.trim(),
        amount: amount,
        unit: selectedUnit,
        notes: notesController.text.trim(),
        expirationDate: selectedDate,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item updated successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating item: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // If no food is provided, show selection list
    if (widget.food == null) {
      return _buildSelectionView();
    }

    // If food is provided, show edit form
    return _buildEditView();
  }

  Widget _buildSelectionView() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text("Please log in")));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Item to Edit"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search items...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase();
                });
              },
            ),
          ),
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
                final filteredFoods = allFoods.where((food) {
                  return food.name.toLowerCase().contains(_searchText);
                }).toList();

                if (filteredFoods.isEmpty) {
                  return const Center(child: Text("No items found"));
                }

                return ListView.builder(
                  itemCount: filteredFoods.length,
                  itemBuilder: (context, index) {
                    final food = filteredFoods[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getCategoryColor(food.category),
                          child: _getCategoryIcon(food.category),
                        ),
                        title: Text(food.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("${food.amount} ${food.unit} • ${food.category}"),
                        trailing: const Icon(Icons.edit, color: Colors.grey),
                        onTap: () {
                          // Navigate to same screen but with food item
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditItemScreen(food: food),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Vegetables': return const Color(0xFF2E7D32).withValues(alpha:0.2);
      case 'Meat': return const Color(0xFFC62828).withValues(alpha:0.2);
      case 'Fish': return const Color(0xFF1565C0).withValues(alpha:0.2);
      case 'Dairy': return const Color(0xFFF9A825).withValues(alpha:0.2);
      case 'Fruits': return const Color(0xFFEF6C00).withValues(alpha:0.2);
      default: return Colors.grey.shade200;
    }
  }

  Widget _getCategoryIcon(String category) {
    String assetPath;
    switch (category) {
      case 'Vegetables': assetPath = "assets/images/veg.png"; break;
      case 'Meat': assetPath = "assets/images/meat.png"; break;
      case 'Fish': assetPath = "assets/images/fish.png"; break;
      case 'Dairy': assetPath = "assets/images/dairy.png"; break;
      case 'Fruits': assetPath = "assets/images/fruit.png"; break;
      default: return const Icon(Icons.fastfood, color: Colors.grey);
    }

    return Image.asset(
      assetPath,
      width: 24,
      height: 24,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, color: Colors.grey),
    );
  }

  Widget _buildEditView() {
    return Scaffold(
      // backgroundColor: Colors.white, // Removed
      appBar: AppBar(
        // backgroundColor: Colors.white, // Removed
        elevation: 0,
        title: const Text(
          "Edit Item",
          style: TextStyle(
            // color: Colors.black, // Removed
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Removed color
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // category dropdown
            DropdownButtonFormField<String>(
              value: ['Vegetables', 'Meat', 'Fish', 'Dairy', 'Fruits', 'Other'].contains(selectedCategory) ? selectedCategory : 'Other',
              items: const [
                DropdownMenuItem(value: 'Vegetables', child: Text('Vegetables')),
                DropdownMenuItem(value: 'Meat', child: Text('Meat')),
                DropdownMenuItem(value: 'Fish', child: Text('Fish')),
                DropdownMenuItem(value: 'Dairy', child: Text('Dairy')),
                DropdownMenuItem(value: 'Fruits', child: Text('Fruits')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => selectedCategory = value);
              },
              decoration: InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // name
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // brand
            TextField(
              controller: brandController,
              decoration: InputDecoration(
                labelText: "Brand",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // amount
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Amount",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: TextEditingController(text: amount.toStringAsFixed(amount.truncateToDouble() == amount ? 0 : 1)),
                  ),
                ),
                const SizedBox(width: 8),
                _roundButton(Icons.add, () {
                  setState(() => amount++);
                }),
                const SizedBox(width: 4),
                _roundButton(Icons.remove, () {
                  if (amount > 0.5) setState(() => amount--);
                }),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    value: selectedUnit,
                    items: const [
                      DropdownMenuItem(value: 'pcs', child: Text('pcs')),
                      DropdownMenuItem(value: 'kg', child: Text('kg')),
                      DropdownMenuItem(value: 'L', child: Text('L')),
                    ],
                    onChanged: (value) {
                      if (value != null) setState(() => selectedUnit = value);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // expiry
            GestureDetector(
              onTap: _pickDate,
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Expiration Date",
                    hintText: "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

             // notes
            TextField(
              controller: notesController,
              decoration: InputDecoration(
                labelText: "Notes",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 30),

            // save item
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E7CC3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _saveItem,
                child: const Text(
                  "Save Changes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // buttons
  Widget _roundButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Color(0xFF8E7CC3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: Colors.white),
      ),
    );
  }
}
