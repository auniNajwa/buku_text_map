import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bukutextly_admins/utils/firestore_service.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String condition;
  final double price;
  final BookCategory category;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.condition,
    required this.price,
    required this.category,
    required this.imageUrl,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      condition: data['condition'] ?? '',
      price: (data['price'] as num).toDouble(),
      category: BookCategory.values.firstWhere(
          (e) => e.toString() == 'BookCategory.${data['category']}'),
      imageUrl: data['image'] ?? '',
    );
  }
}
