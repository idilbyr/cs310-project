import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../utils/constants.dart';

class CreateFridgeScreen extends StatefulWidget {
  static const String routeName = '/create_fridge';
  const CreateFridgeScreen({super.key});

  @override
  State<CreateFridgeScreen> createState() => _CreateFridgeScreenState();
}

class _CreateFridgeScreenState extends State<CreateFridgeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String _selectedIcon = 'Default';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fridge Created Successfully!')),
      );
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Validation Error'),
          content: const Text('Please check the red fields and try again.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Fridge'), backgroundColor: AppColors.primaryColor),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Fridge Details', style: AppTextStyles.headerStyle.copyWith(color: Theme.of(context).textTheme.titleLarge?.color)),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Fridge Name', border: OutlineInputBorder(), prefixIcon: Icon(Icons.kitchen)),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Fridge name cannot be empty';
                  if (value.length < 3) return 'Name must be at least 3 characters';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description (Optional)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.description)),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedIcon,
                decoration: const InputDecoration(labelText: 'Select Icon', border: OutlineInputBorder()),
                items: ['Default', 'Office', 'Home', 'Picnic'].map((icon) => DropdownMenuItem(value: icon, child: Text(icon))).toList(),
                onChanged: (value) => setState(() => _selectedIcon = value!),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text('Create Fridge', style: AppTextStyles.buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
