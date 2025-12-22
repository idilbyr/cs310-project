import 'package:flutter/material.dart';
import '../models/food_model.dart';

// ==========================================
// 3. UPDATED CATEGORY DETAIL SCREEN
// ==========================================
class CategoryDetailScreen extends StatefulWidget {
  static const routeName = '/detailed_category_screen';
  final String categoryName;
  final Color themeColor;
  final String iconPath;
  final List<FoodModel> items;

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
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  List<FoodModel> _filteredItems = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _runFilter(String enteredKeyword) {
    List<FoodModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = widget.items;
    } else {
      results = widget.items
          .where((item) =>
              item.name.toLowerCase().contains(enteredKeyword.toLowerCase())) // case insensitive searching
          .toList();
    }

    setState(() {
      _filteredItems = results; // show related item
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Color.alphaBlend(
        widget.themeColor.withValues(alpha: 0.15),
        Colors.white,
    );
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
                    child: const Icon(Icons.arrow_back, size: 28), // Removed hardcoded color
                  ),
                  const SizedBox(width: 15),

                  // TITLE PILL
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: widget.themeColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: widget.customTextColor, // Border matches the text color you chose
                            width: 2.0
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.categoryName,
                        style: TextStyle(
                          color: widget.customTextColor, // Text matches the background color
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
                      color: widget.themeColor,
                      borderRadius: BorderRadius.circular(15),
                      border:Border.all(
                          color: widget.customTextColor,
                          width: 2.0
                      ),
                    ),

                    child: Image.asset(
                      widget.iconPath,
                      color: widget.customIconColor, // our new custom icon color
                      fit: BoxFit.contain,
                      errorBuilder: (ctx, err, stack) => Icon(Icons.image, color: widget.customTextColor), // Fallback icon
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
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => _runFilter(value),
                  decoration: const InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
                    prefixIcon: Icon(Icons.search, size: 24, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 13), // fully working search bar
                  ),
                ),
              ),
            ),

            // --- TABLE ITEMS ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  return _buildTableItemCard(context, _filteredItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableItemCard(BuildContext context, FoodModel item) {
    final labelBg = widget.themeColor.withValues(alpha:0.4);
    final valueBg = widget.themeColor.withValues(alpha:0.15);
    final borderColor = widget.themeColor;
    
    final formattedDate = "${item.expirationDate.day}/${item.expirationDate.month}/${item.expirationDate.year}";

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildTableRow("Name:", item.name, labelBg, valueBg, borderColor, isTop: true),
              _buildTableRow("Amount:", "${item.amount} ${item.unit}", labelBg, valueBg, borderColor),
              _buildTableRow("Brand:", item.brand, labelBg, valueBg, borderColor),
              _buildTableRow("EXP:", formattedDate, labelBg, valueBg, borderColor),
              _buildTableRow("Notes:", item.notes, labelBg, valueBg, borderColor, isBottom: true),
            ],
          ),
        ),
      ],
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

