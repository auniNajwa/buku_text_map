import 'package:bukutextly_users/utils/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String userId;

  CartService({required this.userId});

  Stream<List<CartItem>> getCartItems() {
    return _db.collection('users/$userId/cart').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CartItem(
          id: doc.id,
          name: doc['name'],
          imageUrl: doc['imageUrl'],
          price: (doc['price'] as num).toDouble(),
        );
      }).toList();
    });
  }

  Future<void> addItemToCart(CartItem item) async {
    await _db.collection('users/$userId/cart').doc(item.id).set({
      'name': item.name,
      'imageUrl': item.imageUrl,
      'price': item.price,
    });
  }

  Future<void> removeItemFromCart(String itemId) async {
    await _db.collection('users/$userId/cart').doc(itemId).delete();
  }

  Future<double> getTotalPrice() async {
    try {
      final snapshot = await _db.collection('users/$userId/cart').get();
      double total = 0.0;

      for (var doc in snapshot.docs) {
        final price = (doc['price'] as num?)?.toDouble() ?? 0.0;
        total += price;
      }

      return total;
    } catch (e) {
      print('Error getting total price: $e');
      return 0.0;
    }
  }

  Future<void> clearCart() async {
    final snapshot = await _db.collection('users/$userId/cart').get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> updateItemQuantity(String itemId, int quantity) async {
    await _db.collection('users/$userId/cart').doc(itemId).update({
      'quantity': quantity,
    });
  }
}
