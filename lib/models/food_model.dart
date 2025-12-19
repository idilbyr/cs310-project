import 'package:cloud_firestore/cloud_firestore.dart';

class FoodModel {
    final String id;
    final String name;
    final String category;
    final String brand;
    final double amount;
    final String unit; // goes with amount 
    final String notes;
    final DateTime expirationDate;
    // setup requirements
    final String createdBy;
    final Timestamp createdAt;

    FoodModel({
        required this.id,
        required this.name,
        required this.category,
        required this.brand,
        required this.amount,
        required this.unit,
        required this.notes,
        required this.expirationDate,
        required this.createdBy,
        required this.createdAt,
    });

    // Factory constructor to create a FoodModel from a Firestore document snapshot
    factory FoodModel.fromSnapshot(DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return FoodModel(
            id: doc.id,
            name: data['name'] ?? '',
            category: data['category'] ?? '',
            brand: data['brand'] ?? '',
            amount: (data['amount'] ?? 0).toDouble(),
            unit: data['unit'] ?? '',
            notes: data['notes'] ?? '',
            expirationDate: (data['expirationDate'] as Timestamp).toDate(),
            createdBy: data['createdBy'] ?? '',
            createdAt: data['createdAt'] ?? Timestamp.now(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            'name': name,
            'category': category,
            'brand': brand,
            'amount': amount,
            'unit': unit,
            'notes': notes,
            'expirationDate': Timestamp.fromDate(expirationDate),
            'createdBy': createdBy,
            'createdAt': createdAt,
        };
    }
}