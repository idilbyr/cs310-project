import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fridge_note/screens/add_edit_item_screen.dart';
import 'detailed_category_screen.dart';
import 'shopping_list.dart';
import '../models/food_model.dart';
import '../services/firestore_services.dart';

class FridgeOverviewScreen extends StatelessWidget {
  static const String routeName = '/fridge_overview';

  const FridgeOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text("Please log in")));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('FRIDGE_1', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: StreamBuilder<List<FoodModel>>(
        stream: FirestoreService().getFoods(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          
          final allFoods = snapshot.data ?? [];
          
          final vegItems = allFoods.where((f) => f.category == 'Vegetables').toList();
          final meatItems = allFoods.where((f) => f.category == 'Meat').toList();
          final fishItems = allFoods.where((f) => f.category == 'Fish').toList();
          final fruitItems = allFoods.where((f) => f.category == 'Fruits').toList();
          final dairyItems = allFoods.where((f) => f.category == 'Dairy').toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
               
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: [

                    _buildCategoryCard(
                        context,
                        "VEGETABLES",
                        const Color(0xFF2E7D32),
                        "assets/images/veg.png",
                        vegItems,
                        textColor: const Color(0xFFfe9f4d)
                    ),

                    _buildCategoryCard(
                        context,
                        "MEAT",
                        const Color(0xFFC62828),
                        "assets/images/meat.png",
                        meatItems,
                        textColor: Colors.white,
                    ),

                    _buildCategoryCard(
                        context,
                        "FISH",
                        const Color(0xFF1565C0),
                        "assets/images/fish.png",
                        fishItems,
                        textColor: const Color(0xFFA0A6AF),
                    ),

                    _buildCategoryCard(
                        context,
                        "FRUITS",
                        const Color(0xFFEF6C00),
                        "assets/images/fruit.png",
                        fruitItems,
                        textColor: const Color(0xFF26A74D),
                    ),

                    _buildCategoryCard(
                        context,
                        "DAIRY",
                        const Color(0xFFF9A825),
                        "assets/images/dairy.png",
                        dairyItems,
                        textColor: const Color(0xFF000000),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7E57C2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ShoppingListScreen())
                          );
                        },
                        child: const Text(
                          "Shopping List",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    Center(
                        child: TextButton(
                            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEditHomeScreen()),);},
                            child: const Text("Add / Edit Item", style: TextStyle(color: Colors.grey))
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
          );
        }
      ),
    );
  }

  // Helper Function for Main Page Cards
  Widget _buildCategoryCard(
      BuildContext context,
      String title,
      Color color,
      String imagePath,
      List<FoodModel> data,
      {Color? textColor, Color? iconColor}
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetailScreen(
              categoryName: title,
              themeColor: color,
              iconPath: imagePath,
              items: data,
              customTextColor: textColor ?? Colors.white, // Defaults to white if not provided
              customIconColor: iconColor, // Defaults to null if not provided
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: 100,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 2),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    letterSpacing: 1.0
                ),
              ),
              const SizedBox(height: 5),
              Image.asset(
                imagePath,
                width: 40,
                height: 40,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 40, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

