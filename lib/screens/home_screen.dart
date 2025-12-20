import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme__provider.dart';
import '../providers/auth_providers.dart';
import '../providers/fridge_provider.dart';
import '../services/firestore_services.dart';
import '../models/fridge_model.dart';
import '../utils/constants.dart'; 
import 'create_fridge_screen.dart'; 
import 'fridge_overview_screen.dart';
import 'shopping_list.dart';
import 'about_screen.dart';

class HomeScreen extends StatelessWidget {
  
  static const String routeName = '/home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('FridgeNote', style: AppTextStyles.headerStyle.copyWith(color: Theme.of(context).textTheme.titleLarge?.color)),
        centerTitle: true,
        // backgroundColor: Colors.white, // Removed
        elevation: 0,
        // iconTheme: const IconThemeData(color: AppColors.textColor), // Removed
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Profil sayfasına git (İleride eklenecek)
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search fridge...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: AppColors.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              
         
              TextButton(
                onPressed: () {
                  // Join Screen'e git (İleride eklenecek)
                },
                child: Text(
                  'Join via link',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              
              const SizedBox(height: 40),

              if (user != null)
                StreamBuilder<List<FridgeModel>>(
                  stream: FirestoreService().getFridges(user.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    final fridges = snapshot.data ?? [];

                    if (fridges.isEmpty) {
                      return const Text('No fridges found. Create one!');
                    }

                    return Column(
                      children: fridges.map((fridge) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Provider.of<FridgeProvider>(context, listen: false).selectFridge(fridge);
                              Navigator.pushNamed(context, FridgeOverviewScreen.routeName, arguments: fridge);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                              elevation: 5,
                            ),
                            child: Text(
                              fridge.name,
                              style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                )
              else
                 const Text('Please log in to see your fridges'),

              const SizedBox(height: 30),

              // 4. "Create New" (+) Yuvarlak Buton -> Screen 4'e Gider
              InkWell(
                onTap: () {
                  // Screen 4: goes Create Fridge 
                  Navigator.pushNamed(context, CreateFridgeScreen.routeName);
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add, color: AppColors.primaryColor, size: 35),
                ),
              ),
              const SizedBox(height: 10),
              const Text("Create New", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
      
      // 5. Alt Navigasyon Barı (Görsel Amaçlı)
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 1, // Home seçili dursun
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          if (index == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Coming Soon!'),
                duration: Duration(seconds: 1),
              ),
            );
          } else if (index == 2) {
            Navigator.pushNamed(context, AboutScreen.routeName);
          }
        },
      ),
    );
  }
}
