import 'package:flutter/material.dart';

import 'about_screen.dart';
import 'create_fridge_screen.dart';

class DummyHomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  const DummyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TEMP: Home Screen'),
        actions: [
          IconButton(
            tooltip: 'About',
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, AboutScreen.routeName);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Temporary Home (Furkan Branch)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'This page was a placeholder.\nNow buttons are functional for Phase 3.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // ✅ Works: goes to Create Fridge screen
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.kitchen),
                  label: const Text('Go to Create Fridge'),
                  onPressed: () {
                    Navigator.pushNamed(context, CreateFridgeScreen.routeName);
                  },
                ),
              ),

              const SizedBox(height: 12),

              // ✅ Works: goes to About screen
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.info),
                  label: const Text('Go to About'),
                  onPressed: () {
                    Navigator.pushNamed(context, AboutScreen.routeName);
                  },
                ),
              ),

              const SizedBox(height: 12),

              // ✅ Works: goes back if possible
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Go Back'),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      // if it can't pop, just show a small message (still "working", not empty)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No previous screen to go back to.'),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
