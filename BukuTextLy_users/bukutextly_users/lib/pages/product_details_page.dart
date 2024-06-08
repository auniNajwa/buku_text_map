import 'package:bukutextly_users/pages/edit_product_page.dart';
import 'package:bukutextly_users/utils/cart_model.dart';
import 'package:bukutextly_users/utils/cart_service.dart';
import 'package:bukutextly_users/utils/firestore_service.dart';
import 'package:bukutextly_users/utils/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;
  final String userId; // Add userId

  const ProductDetailsPage({
    super.key,
    required this.productId,
    required this.userId, // Add userId
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Future<Product> _productFuture;
  final FirestoreService _firestoreService = FirestoreService();
  late CartService _cartService;

  @override
  void initState() {
    super.initState();
    _productFuture = _fetchProduct(widget.productId);
    _cartService = CartService(
        userId: widget.userId); // Initialize CartService with userId
  }

  Future<Product> _fetchProduct(String productId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .get();
    return Product.fromFirestore(doc);
  }

  Future<void> _deleteProduct() async {
    await _firestoreService.deleteProduct(widget.productId);
    Navigator.of(context).pop();
  }

  Future<void> _addToCart(Product product) async {
    final cartItem = CartItem(
      id: product.id,
      name: product.name,
      imageUrl: product.imageUrl,
      price: product.price,
    );
    await _cartService.addItemToCart(cartItem);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditProductPage(productId: widget.productId),
                  ),
                );
              } else if (value == 'delete') {
                await _deleteProduct();
              }
            },
            itemBuilder: (BuildContext context) {
              return {'edit', 'delete'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice[0].toUpperCase() + choice.substring(1)),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: FutureBuilder<Product>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading product details'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Product not found'));
          } else {
            final product = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 250.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(product.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '\RM ${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Product Details',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text(
                        'Condition: ',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.condition,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text(
                        'Category: ',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.category.toString().split('.').last,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => _addToCart(product),
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
