import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'create_fridge_screen.dart';
import 'fridge_overview_screen.dart';
// 1. IMPORT THE SCREENS HERE
import 'join_fridge_screen.dart';
import 'settings_profile_screen.dart';

class HomeScreen extends StatelessWidget {

  static const String routeName = '/home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FridgeNote', style: AppTextStyles.headerStyle),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // 2. NAVIGATE TO PROFILE SCREEN
              Navigator.pushNamed(context, SettingsProfileScreen.routeName);
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
                  // 3. NAVIGATE TO JOIN FRIDGE SCREEN
                  Navigator.pushNamed(context, JoinFridgeScreen.routeName);
                },
                child: const Text(
                  'Join via link',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.textColor,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // "My Fridge" Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, FridgeOverviewScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  elevation: 5,
                ),
                child: const Text(
                  'My Fridge',
                  style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 30),

              // "Create New" Button
              InkWell(
                onTap: () {
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

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          // 4. NAVIGATE VIA BOTTOM BAR (Optional)
          if (index == 2) {
            Navigator.pushNamed(context, SettingsProfileScreen.routeName);
          }
          // You can also add logic for index == 0 (Shop) here later
        },
      ),
    );
  }
}
