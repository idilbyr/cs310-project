// lib/screens/join_fridge_screen.dart

import 'package:flutter/material.dart';
import '../utils/constants.dart';

class JoinFridgeScreen extends StatefulWidget {
  static const routeName = '/join-fridge';

  const JoinFridgeScreen({super.key});

  @override
  State<JoinFridgeScreen> createState() => _JoinFridgeScreenState();
}

class _JoinFridgeScreenState extends State<JoinFridgeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _joinCodeController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hata'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Tamam'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Örnek: Basit bir kod uzunluğu kontrolü
      if (_joinCodeController.text.length != 6) {
        _showErrorDialog('Lütfen 6 haneli geçerli bir kod girin.');
        return;
      }

      // Başarılı olursa gezinme (Örn: /fridge-overview rotasına)
      print('Başarıyla katıldı: ${_joinCodeController.text}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Buzdolabına başarıyla katıldınız!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Responsiveness için SingleChildScrollView kullanıldı.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buzdolabına Katıl'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: AppPaddings.screenPadding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Katılım Kodu veya Bağlantısını Girin',
                style: AppStyles.title.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _joinCodeController,
                decoration: InputDecoration(
                  labelText: 'Kod veya Link',
                  hintText: 'Paste from clipboard',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.link),
                ),
                // Form Validation (Satır içi hata mesajı)
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir kod veya link girin.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Katıl',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Center(child: Text('veya', style: AppStyles.body)),
              TextButton(
                onPressed: () {},
                child: Text('Yardım? Kod nasıl alınır?', style: AppStyles.link),
              ),
            ],
          ),
        ),
      ),
    );
  }
}