import 'package:flutter/material.dart';

class DummyHomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  const DummyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TEMP: Home Screen')),
      body: const Center(
        child: Text(
          'This page is a placeholder until navigation is merged.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}
