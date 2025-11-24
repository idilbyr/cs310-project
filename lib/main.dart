import 'package:flutter/material.dart';
import '../screens/about_screen.dart';
import '../screens/create_fridge_screen.dart';
import 'screens/login_page.dart';
// Berkan
import 'screens/home_screen.dart';           // Screen 3
import 'screens/fridge_overview_screen.dart'; // Screen 6
// Eksik sayfalar için geçici sayfa
// Renkler ve Tema
import 'utils/constants.dart';
// ALP
import 'screens/add_item_screen.dart';
import 'screens/edit_item_screen.dart';
import 'screens/expiring_soon_screen.dart';
import 'screens/add_edit_item_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berkan Branch Step 2.2',
      debugShowCheckedModeBanner: false,
      
     
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.deepPurple),
          ),
        ),
      ),
      initialRoute: LoginPage.routeName,

      
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        // Screen 3: Ana Sayfa
        HomeScreen.routeName: (context) => const HomeScreen(),
        // Screen 6: Detay Sayfası
        FridgeOverviewScreen.routeName: (context) => const FridgeOverviewScreen(),
        CreateFridgeScreen.routeName: (context) => const CreateFridgeScreen(),
        // Screen 12: Your Other Task
        AboutScreen.routeName: (context) => const AboutScreen(),
        AddItemScreen.routeName: (context) => const AddItemScreen(),
        EditItemScreen.routeName: (context) => const EditItemScreen(),
        ExpiringSoonScreen.routeName: (context) => const ExpiringSoonScreen(),
        AddEditHomeScreen.routeName: (context) => const AddEditHomeScreen(),

      },
    );
  }
}
