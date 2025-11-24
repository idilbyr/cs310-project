

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
