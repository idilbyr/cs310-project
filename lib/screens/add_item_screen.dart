import 'package:flutter/material.dart';

class AddItemScreen extends StatefulWidget {
  static const routeName = '/add_item';
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String selectedCategory = 'Vegetables';
  String selectedUnit = 'pcs';
  int amount = 1;
  DateTime? selectedDate;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "Add Item",
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, size: 18, color: Colors.blue),
              label: const Text(
                "Back to Add / Edit",
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
            const SizedBox(height: 8),

            const Text(
              "Fridge 1",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            const Text(
              "Total Items:",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 20),

            // CATEGORY dropdown menu
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: const [
                DropdownMenuItem(value: 'Vegetables', child: Text('Vegetables')),
                DropdownMenuItem(value: 'Meat', child: Text('Meat')),
                DropdownMenuItem(value: 'Fish', child: Text('Fish')),
                DropdownMenuItem(value: 'Dairy', child: Text('Dairy')),
                DropdownMenuItem(value: 'Fruit', child: Text('Fruit')),
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
                    controller: TextEditingController(text: amount.toString()),
                  ),
                ),
                const SizedBox(width: 8),
                _roundButton(Icons.add, () {
                  setState(() => amount++);
                }),
                const SizedBox(width: 4),
                _roundButton(Icons.remove, () {
                  if (amount > 1) setState(() => amount--);
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
                    hintText: selectedDate == null
                        ? "Select a date"
                        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // save
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E7CC3), // mor
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Save işlemleri
                },
                child: const Text(
                  "Save Item",
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
