import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/food_model.dart';

class FirestoreService{
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    Stream<List<FoodModel>> getFoods(String userId) {
        return _db.collection('foods').where('createdBy', isEqualTo: userId) // security
        .orderBy('expirationDate',descending: false) // soonest expiration first
        .snapshots().map((snapshot) => snapshot.docs.map((doc) => FoodModel.fromSnapshot(doc)).toList());
    }
    Future<void> addFood({required String name,
        required String category,
        required String brand,
        required double amount,
        required String unit,
        required String notes,
        required DateTime expirationDate,
        required String userId,}) async{
        await _db.collection('foods').add({
            'name': name,
            'category': category,
            'brand': brand,
            'amount': amount,
            'unit': unit,
            'notes': notes,
            'expirationDate': Timestamp.fromDate(expirationDate),
            'createdBy': userId,
            'createdAt': FieldValue.serverTimestamp(),
        });  
    }
    Future<void> updateFoodAmount(String docId, double newAmount) async {
        await _db.collection('foods').doc(docId).update({
            'amount': newAmount,
        });
    }

    Future<void> updateFood({
      required String docId,
      required String name,
      required String category,
      required String brand,
      required double amount,
      required String unit,
      required String notes,
      required DateTime expirationDate,
    }) async {
      await _db.collection('foods').doc(docId).update({
        'name': name,
        'category': category,
        'brand': brand,
        'amount': amount,
        'unit': unit,
        'notes': notes,
        'expirationDate': Timestamp.fromDate(expirationDate),
      });
    }

    Future<void> deleteFood(String docId) async {
        await _db.collection('foods').doc(docId).delete();
    }
}