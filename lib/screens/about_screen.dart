import 'package:flutter/material.dart';
import '../utils/constants_f.dart';

class AboutScreen extends StatefulWidget {
  static const String routeName = '/about';
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final List<String> _teamMembers = ['Ali (Developer)', 'T (Teammate)', 'İ (Teammate)', 'Zeynep (Product Owner)'];

  void _removeMember(int index) {
    setState(() {
      _teamMembers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About / Help'), backgroundColor: AppColors.primaryColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 100, width: 100, color: Colors.grey[300],
                  child: const Icon(Icons.kitchen, size: 50, color: AppColors.primaryColor),
                ),
              ),
              const SizedBox(height: 10),
              const Center(child: Text('FridgeMaster v1.0', style: AppTextStyles.headerStyle)),
              const Divider(),
              const Text('How to Use:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              const Text('1. Create a fridge.\n2. Share code.\n3. Add items.', style: AppTextStyles.bodyStyle),
              const SizedBox(height: 20),
              const Text('Powered By:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Center(
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/2728/2728078.png', 
                  height: 80,
                  errorBuilder: (context, error, stackTrace) => const Text('Failed to load online images'),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Team Members (Swipe/Click to remove):', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _teamMembers.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3, margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: AppColors.accentColor, child: Text(_teamMembers[index][0])),
                      title: Text(_teamMembers[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: AppColors.errorColor),
                        onPressed: () => _removeMember(index),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
