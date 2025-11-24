import 'package:flutter/material.dart';
// Your screens
import 'screens/create_fridge_screen.dart'; // Screen 4
import 'screens/about_screen.dart';         // Screen 12
// Temporary page (To avoid navigation errors)
import 'screens/temp_pages.dart';
// Colors and Fonts
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furkan Branch Step 2.2',
      debugShowCheckedModeBanner: false, // Removes the 'Debug' banner from top right
      
      // Theme Settings (Using Utility class)
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        fontFamily: 'Roboto', // Project requirement: Custom Font
        useMaterial3: true,
      ),

      // The app will launch with "Create Fridge" screen first for testing
      initialRoute: CreateFridgeScreen.routeName,

      // Routes (Named Navigation)
      routes: {
        // Screen 4: Your Main Task
        CreateFridgeScreen.routeName: (context) => const CreateFridgeScreen(),
        
        // Screen 12: Your Other Task
        AboutScreen.routeName: (context) => const AboutScreen(),

        // NOTE: Your screens try to navigate to 'Home' upon success.
        // Since this branch does not have the Home Screen, we route to the dummy page.
        DummyHomeScreen.routeName: (context) => const DummyHomeScreen(),
      },
    );
  }
}
