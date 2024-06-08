import 'package:bukutextly_admins/utils/feedback_model.dart';
import 'package:bukutextly_admins/utils/product_model.dart';
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
    required String imageUrl,
  }) async {
    try {
      await _db.collection('products').add({
        'name': name,
        'description': description,
        'condition': condition,
        'price': price,
        'category': category.toString().split('.').last,
        'image': imageUrl,
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

  Stream<List<Product>> getProducts({String searchQuery = ''}) {
    Query query = _db.collection('products');

    if (searchQuery.isNotEmpty) {
      query = query
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThanOrEqualTo: '$searchQuery\uf8ff');
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromFirestore(doc);
      }).toList();
    });
  }

  Future<Product> getProductById(String productId) async {
    final doc = await _db.collection('products').doc(productId).get();
    return Product.fromFirestore(doc);
  }

  Future<void> addFeedback(FeedbackModel feedback) async {
    try {
      await _db
          .collection('feedbacks')
          .doc(feedback.id)
          .set(feedback.toFirestore());
    } catch (e) {
      print('Error adding feedback: $e');
    }
  }

  Future<void> updateFeedback(FeedbackModel feedback) async {
    try {
      await _db
          .collection('feedbacks')
          .doc(feedback.id)
          .update(feedback.toFirestore());
    } catch (e) {
      print('Error updating feedback: $e');
    }
  }

  Future<void> deleteFeedback(String feedbackId) async {
    try {
      await _db.collection('feedbacks').doc(feedbackId).delete();
    } catch (e) {
      print('Error deleting feedback: $e');
    }
  }

  Stream<List<FeedbackModel>> getUserFeedbacks(String userId) {
    return _db
        .collection('feedbacks')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FeedbackModel.fromFirestore(doc.data()!))
            .toList());
  }
}
