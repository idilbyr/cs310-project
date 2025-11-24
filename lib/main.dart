import 'package:flutter/material.dart';
// Berkan
import 'screens/home_screen.dart';           // Screen 3
import 'screens/fridge_overview_screen.dart'; // Screen 6
// Eksik sayfalar için geçici sayfa
import 'screens/temp_pages.dart';
// Renkler ve Tema
import 'utils/constants.dart';

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

       
        '/dummy': (context) => const DummyPage(),
        '/create_fridge': (context) => const DummyPage(), 
      },
    );
  }
}
