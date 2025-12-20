import 'package:cloud_firestore/cloud_firestore.dart';

class FridgeModel {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String createdBy;
  final List<String> members;
  final DateTime createdAt;

  FridgeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.createdBy,
    required this.members,
    required this.createdAt,
  });

  factory FridgeModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FridgeModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      icon: data['icon'] ?? 'Default',
      createdBy: data['createdBy'] ?? '',
      members: List<String>.from(data['members'] ?? []),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'icon': icon,
      'createdBy': createdBy,
      'members': members,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
