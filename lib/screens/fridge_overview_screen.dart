import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';
import 'detailed_category_screen.dart';
import 'shopping_list.dart';
import '../utils/item_data.dart';

class FridgeOverviewScreen extends StatelessWidget {
  static const String routeName = '/fridge_overview';

  const FridgeOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
           
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
                    textColor: const Color(0xFFfe9f4d)// <--- EDIT HERE: Title Text Color
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


// ==========================================
// 3. UPDATED CATEGORY DETAIL SCREEN
// ==========================================
class CategoryDetailScreen extends StatelessWidget {
  final String categoryName;
  final Color themeColor;
  final String iconPath;
  final List<FridgeItem> items;

  // New variables for manual control
  final Color customTextColor;
  final Color? customIconColor;

  const CategoryDetailScreen({
    super.key,
    required this.categoryName,
    required this.themeColor,
    required this.iconPath,
    required this.items,
    this.customTextColor = Colors.white, // Default white
    this.customIconColor, // Default null
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = themeColor.withOpacity(0.15);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // --- HEADER ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
                  ),
                  const SizedBox(width: 15),

                  // TITLE PILL
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: customTextColor, // Border matches the text color you chose
                            width: 2.0
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        categoryName,
                        style: TextStyle(
                          color: customTextColor, // <--- USES YOUR MANUAL COLOR
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  // ICON BOX
                  Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.circular(15),
                      border:Border.all(
                          color: customTextColor,
                          width: 2.0
                      ),
                    ),

                    child: Image.asset(
                      iconPath,
                      color: customIconColor, // <--- USES YOUR MANUAL COLOR
                      fit: BoxFit.contain,
                      errorBuilder: (ctx, err, stack) => Icon(Icons.image, color: customTextColor),
                    ),
                  ),
                ],
              ),
            ),

            // --- SEARCH BAR ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
                    prefixIcon: Icon(Icons.search, size: 24, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 13),
                  ),
                ),
              ),
            ),

            // --- TABLE ITEMS ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _buildTableItemCard(items[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableItemCard(FridgeItem item) {
    final labelBg = themeColor.withOpacity(0.4);
    final valueBg = themeColor.withOpacity(0.15);
    final borderColor = themeColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildTableRow("Name:", item.name, labelBg, valueBg, borderColor, isTop: true),
          _buildTableRow("Amount:", item.amount, labelBg, valueBg, borderColor),
          _buildTableRow("Brand:", item.brand, labelBg, valueBg, borderColor),
          _buildTableRow("EXP:", item.exp, labelBg, valueBg, borderColor),
          _buildTableRow("Notes:", item.notes, labelBg, valueBg, borderColor, isBottom: true),
        ],
      ),
    );
  }

  Widget _buildTableRow(
      String label,
      String value,
      Color labelColor,
      Color valueColor,
      Color borderColor,
      {bool isTop = false, bool isBottom = false}
      ) {
    final radius = isTop
        ? const Radius.circular(5)
        : (isBottom ? const Radius.circular(5) : Radius.zero);

    return Container(
      decoration: BoxDecoration(
        border: isBottom ? null : Border(bottom: BorderSide(color: Colors.grey.shade600, width: 0.5)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  color: labelColor,
                  borderRadius: BorderRadius.only(topLeft: radius, bottomLeft: radius),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
            ),
            Container(width: 0.5, color: Colors.grey.shade600),
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  color: valueColor,
                  borderRadius: BorderRadius.only(topRight: radius, bottomRight: radius),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
