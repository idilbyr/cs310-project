import 'package:flutter/material.dart';
import '../models/fridge_model.dart';

class FridgeProvider with ChangeNotifier {
  FridgeModel? _selectedFridge;

  FridgeModel? get selectedFridge => _selectedFridge;

  void selectFridge(FridgeModel fridge) {
    _selectedFridge = fridge;
    notifyListeners();
  }

  void clearSelectedFridge() {
    _selectedFridge = null;
    notifyListeners();
  }
}
