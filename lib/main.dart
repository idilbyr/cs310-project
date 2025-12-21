import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'providers/theme__provider.dart';
import 'providers/auth_providers.dart';
import 'providers/fridge_provider.dart';
import 'screens/about_screen.dart';
import 'screens/create_fridge_screen.dart';
import 'screens/login_page.dart';
// Berkan
import 'screens/home_screen.dart';           // Screen 3
import 'screens/fridge_overview_screen.dart'; // Screen 6
// Eksik sayfalar için geçici sayfa
// Renkler ve Tema
// ALP
import 'screens/add_item_screen.dart';
import 'screens/expiring_soon_screen.dart';
import 'screens/add_edit_item_screen.dart';
import 'screens/shopping_list.dart';
import 'screens/user_settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FridgeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      title: 'Fridge Note',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
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
      darkTheme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade600),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade600),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.deepPurpleAccent),
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
        ExpiringSoonScreen.routeName: (context) => const ExpiringSoonScreen(),
        AddEditHomeScreen.routeName: (context) => const AddEditHomeScreen(),
        ShoppingListScreen.routeName: (context) => const ShoppingListScreen(),
        UserSettingsScreen.routeName: (context) => const UserSettingsScreen(),
      },
    );
  }
}
