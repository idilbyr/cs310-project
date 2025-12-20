import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingItemModel {
  final String id;
  final String name;
  final bool isChecked;
  final String createdBy;
  final String? fridgeId;

  ShoppingItemModel({
    required this.id,
    required this.name,
    required this.isChecked,
    required this.createdBy,
    this.fridgeId,
  });

  factory ShoppingItemModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ShoppingItemModel(
      id: doc.id,
      name: data['name'] ?? '',
      isChecked: data['isChecked'] ?? false,
      createdBy: data['createdBy'] ?? '',
      fridgeId: data['fridgeId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isChecked': isChecked,
      'createdBy': createdBy,
      'fridgeId': fridgeId,
    };
  }
}
