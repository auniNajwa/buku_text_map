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

  Stream<List<ProductWithID>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductWithID.fromSnapshot(doc);
      }).toList();
    });
  }

  // New method to get all products
  Future<List<ProductWithID>> getAllProducts() async {
    try {
      final QuerySnapshot querySnapshot =
          await _db.collection('products').get();
      return querySnapshot.docs.map((doc) {
        return ProductWithID.fromSnapshot(doc);
      }).toList();
    } catch (e) {
      print('Error getting products: $e');
      return [];
    }
  }
}

class ProductWithID {
  final String id;
  final String name;
  final String description;
  final String condition;
  final double price;
  final BookCategory category;

  ProductWithID({
    required this.id,
    required this.name,
    required this.description,
    required this.condition,
    required this.price,
    required this.category,
  });

  factory ProductWithID.fromSnapshot(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return ProductWithID(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      condition: data['condition'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      category: _parseCategory(data['category'] ?? ''),
    );
  }

  static BookCategory _parseCategory(String categoryString) {
    switch (categoryString.toLowerCase()) {
      case 'computerscience':
        return BookCategory.computerscience;
      case 'maths':
        return BookCategory.maths;
      case 'science':
        return BookCategory.science;
      case 'engineering':
        return BookCategory.engineering;
      case 'mechanical':
        return BookCategory.mechanical;
      default:
        return BookCategory.computerscience; // Default to computerscience
    }
  }
}
