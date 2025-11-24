import 'package:flutter/material.dart';

// ==========================================
// 1. DATA MODELS & MOCK DATA
// ==========================================
class FridgeItem {
  final String name;
  final String amount;
  final String brand;
  final String exp;
  final String notes;

  FridgeItem(this.name, this.amount, this.brand, this.exp, this.notes);
}

final List<FridgeItem> vegItems = [
  FridgeItem("Broccoli", "2 heads", "FreshFarm", "12/11/2025", "For soup"),
  FridgeItem("Carrots", "1 kg", "OrganicCo", "15/11/2025", ""),
];

final List<FridgeItem> meatItems = [
  FridgeItem("Chicken Breast", "500g", "Butcher", "09/11/2025", "Freeze"),
  FridgeItem("Ground Beef", "1 kg", "Market", "08/11/2025", "Tacos"),
];

final List<FridgeItem> fishItems = [
  FridgeItem("Salmon", "2 fillets", "SeaFresh", "07/11/2025", "Expiring"),
];

final List<FridgeItem> fruitItems = [
  FridgeItem("Apples", "6 pcs", "Orchard", "20/11/2025", "Crispy"),
  FridgeItem("Bananas", "1 bunch", "Chiquita", "10/11/2025", "Brown"),
];

final List<FridgeItem> dairyItems = [
  FridgeItem("Milk", "1 Liter", "HappyCow", "11/11/2025", "Lactose free"),
  FridgeItem("Cheddar", "200g", "Kraft", "25/12/2025", ""),
];
