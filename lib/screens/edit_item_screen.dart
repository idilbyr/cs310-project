import 'package:flutter/material.dart';
import '../models/food_model.dart';
import '../services/firestore_services.dart';

class EditItemScreen extends StatefulWidget {
  static const routeName = '/edit_item';
  final FoodModel food;

  const EditItemScreen({super.key, required this.food});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late String selectedCategory;
  late String selectedUnit;
  late double amount;
  late DateTime selectedDate;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.food.category;
    selectedUnit = widget.food.unit;
    amount = widget.food.amount;
    selectedDate = widget.food.expirationDate;
    nameController.text = widget.food.name;
    brandController.text = widget.food.brand;
    notesController.text = widget.food.notes;
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
    try {
      await FirestoreService().updateFood(
        docId: widget.food.id,
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
