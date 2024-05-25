import 'package:cloud_firestore/cloud_firestore.dart';

enum BookCategory {
  computerscience,
  maths,
  science,
  engineering,
  mechanical,
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addProduct({
    required String name,
    required String description,
    required String condition,
    required double price,
    required BookCategory category,
  }) async {
    try {
      await _db.collection('products').add({
        'name': name,
        'description': description,
        'condition': condition,
        'price': price,
        'category': category.toString().split('.').last,
        'timestamp': FieldValue.serverTimestamp(), // To add a timestamp
      });
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> updateProduct({
    required String productId,
    required String name,
    required String description,
    required String condition,
    required double price,
    required BookCategory category,
  }) async {
    try {
      await _db.collection('products').doc(productId).update({
        'name': name,
        'description': description,
        'condition': condition,
        'price': price,
        'category': category.toString().split('.').last,
        'timestamp': FieldValue.serverTimestamp(), // Update the timestamp
      });
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _db.collection('products').doc(productId).delete();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromFirestore(doc);
      }).toList();
    });
  }
}

class Product {
  final String id;
  final String name;
  final String description;
  final String condition;
  final double price;
  final BookCategory category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.condition,
    required this.price,
    required this.category,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      condition: data['condition'] ?? '',
      price: (data['price'] as num).toDouble() ?? 0.0,
      category: BookCategory.values.firstWhere(
          (e) => e.toString() == 'BookCategory.${data['category']}'),
    );
  }
}
