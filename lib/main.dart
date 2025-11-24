import 'package:flutter/material.dart';
import 'package:fridge_note/models/fridge_item.dart';
import 'package:fridge_note/screens/category_detail_screen.dart';
import 'package:fridge_note/screens/shopping_list_screen.dart'; 
void main() {
  runApp(const FridgeNoteApp());
}

class FridgeNoteApp extends StatelessWidget {
  const FridgeNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FridgeNote',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const FridgeMainPage(),
    );
  }
}

// ==========================================
// 2. FRIDGE MAIN PAGE
// ==========================================
class FridgeMainPage extends StatelessWidget {
  const FridgeMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text("FRIDGE_1", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.receipt_long, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey),
                  hintText: "Search...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // Categories List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [

                // -----------------------------------------------------------------
                // 1. VEGETABLES
                // -----------------------------------------------------------------
                _buildCategoryCard(
                    context,
                    "VEGETABLES",
                    const Color(0xFF2E7D32),      // <--- EDIT HERE: Background Color (Green)
                    "assets/images/veg.png",
                    vegItems,
                    textColor: Color(0xFFfe9f4d)// <--- EDIT HERE: Title Text Color
                ),

                // -----------------------------------------------------------------
                // 2. MEAT
                // -----------------------------------------------------------------
                _buildCategoryCard(
                    context,
                    "MEAT",
                    const Color(0xFFC62828),      // <--- EDIT HERE: Background Color (Red)
                    "assets/images/meat.png",
                    meatItems,
                    textColor: Colors.white,      // <--- EDIT HERE: Title Text Color
                ),

                // -----------------------------------------------------------------
                // 3. FISH
                // -----------------------------------------------------------------
                _buildCategoryCard(
                    context,
                    "FISH",
                    const Color(0xFF1565C0),      // <--- EDIT HERE: Background Color (Blue)
                    "assets/images/fish.png",
                    fishItems,
                    textColor: Color(0xFFA0A6AF),      // <--- EDIT HERE: Title Text Color
                ),

                // -----------------------------------------------------------------
                // 4. FRUITS
                // -----------------------------------------------------------------
                _buildCategoryCard(
                    context,
                    "FRUITS",
                    const Color(0xFFEF6C00),      // <--- EDIT HERE: Background Color (Orange)
                    "assets/images/fruit.png",
                    fruitItems,
                    textColor: Color(0xFF26A74D),      // <--- EDIT HERE: Title Text Color
                ),

                // -----------------------------------------------------------------
                // 5. DAIRY
                // (Example: Black text looks better on Yellow)
                // -----------------------------------------------------------------
                _buildCategoryCard(
                    context,
                    "DAIRY",
                    const Color(0xFFF9A825),      // <--- EDIT HERE: Background Color (Yellow)
                    "assets/images/dairy.png",
                    dairyItems,
                    textColor: Color(0xFF000000),      // <--- EDIT HERE: Changed to BLACK
                ),

                const SizedBox(height: 20),

                // Shopping List Button
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7E57C2), // Purple
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
                        onPressed: () {},
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

  // Helper Function for Main Page Cards
  Widget _buildCategoryCard(
      BuildContext context,
      String title,
      Color color,
      String imagePath,
      List<FridgeItem> data,
      {Color? textColor, Color? iconColor} // Optional Custom Colors
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
