import 'package:flutter/material.dart';
import 'package:fridge_note/screens/about_screen.dart';
import 'package:fridge_note/screens/create_fridge_screen.dart';
// Berkan
import 'screens/home_screen.dart';           // Screen 3
import 'screens/fridge_overview_screen.dart'; // Screen 6
// Eksik sayfalar için geçici sayfa
// Renkler ve Tema
import 'utils/constants_f.dart';

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
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        fontFamily: 'Roboto',
        useMaterial3: true,
        // AppBar teması
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textColor),
          titleTextStyle: AppTextStyles.headerStyle,
        ),
      ),

   
      initialRoute: HomeScreen.routeName,

      
      routes: {
        // Screen 3: Ana Sayfa
        HomeScreen.routeName: (context) => const HomeScreen(),
        // Screen 6: Detay Sayfası
        FridgeOverviewScreen.routeName: (context) => const FridgeOverviewScreen(),
        CreateFridgeScreen.routeName: (context) => const CreateFridgeScreen(),
        // Screen 12: Your Other Task
        AboutScreen.routeName: (context) => const AboutScreen(),
      },
    );
  }
}
