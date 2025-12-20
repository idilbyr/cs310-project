import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/food_model.dart';
import '../models/fridge_model.dart';

class FirestoreService{
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    Stream<List<FoodModel>> getFoods(String userId) {
        return _db.collection('foods').where('createdBy', isEqualTo: userId) // security
        .orderBy('expirationDate',descending: false) // soonest expiration first
        .snapshots().map((snapshot) => snapshot.docs.map((doc) => FoodModel.fromSnapshot(doc)).toList());
    }

    Stream<List<FoodModel>> getFoodsForFridge(String fridgeId) {
      return _db
          .collection('foods')
          .where('fridgeId', isEqualTo: fridgeId)
          .snapshots()
          .map((snapshot) {
        final foods =
            snapshot.docs.map((doc) => FoodModel.fromSnapshot(doc)).toList();
        foods.sort((a, b) => a.expirationDate.compareTo(b.expirationDate));
        return foods;
      });
    }

    Future<void> addFood({required String name,
        required String category,
        required String brand,
        required double amount,
        required String unit,
        required String notes,
        required DateTime expirationDate,
        required String userId,
        String? fridgeId,
        }) async{
        await _db.collection('foods').add({
            'name': name,
            'category': category,
            'brand': brand,
            'amount': amount,
            'unit': unit,
            'notes': notes,
            'expirationDate': Timestamp.fromDate(expirationDate),
            'createdBy': userId,
            'fridgeId': fridgeId,
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

    // Fridge Methods
    Future<void> createFridge({
      required String name,
      required String description,
      required String icon,
      required String userId,
    }) async {
      await _db.collection('fridges').add({
        'name': name,
        'description': description,
        'icon': icon,
        'createdBy': userId,
        'members': [userId],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    Stream<List<FridgeModel>> getFridges(String userId) {
      return _db
          .collection('fridges')
          .where('members', arrayContains: userId)
          .snapshots()
          .map((snapshot) {
        final fridges =
            snapshot.docs.map((doc) => FridgeModel.fromSnapshot(doc)).toList();
        fridges.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return fridges;
      });
    }

    Future<FridgeModel?> getFridge(String fridgeId) async {
      final doc = await _db.collection('fridges').doc(fridgeId).get();
      if (doc.exists) {
        return FridgeModel.fromSnapshot(doc);
      }
      return null;
    }
}