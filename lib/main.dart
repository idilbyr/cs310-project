// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/join_fridge_screen.dart'; 
import 'screens/settings_profile_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FridgeNote',
      theme: ThemeData(
        // Custom Font gereksinimi için font family'yi burada ayarlayın
        primarySwatch: Colors.deepPurple,
      ),
      // Named Routes Gereksinimi
      initialRoute: SettingsProfileScreen.routeName, 
      routes: {
        JoinFridgeScreen.routeName: (ctx) => const JoinFridgeScreen(),
        SettingsProfileScreen.routeName: (ctx) => const SettingsProfileScreen(),
        // Diğer ekranlarınızın rotaları...
      },
    );
  }
}
