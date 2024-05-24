import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class ProductDetailPage extends StatefulWidget {
  final String productId; // Update to accept product ID

  const ProductDetailPage({
    super.key,
    required this.productId, // Update constructor to accept product ID
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late DocumentSnapshot? productSnapshot; // Declare productSnapshot as nullable

  @override
  void initState() {
    super.initState();
    fetchProductDetails(); // Fetch product details when page initializes
  }

  void fetchProductDetails() async {
    try {
      final productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId)
          .get();
      if (productDoc.exists) {
        setState(() {
          productSnapshot = productDoc; // Assign fetched product details
        });
      } else {
        // Product not found in Firestore
        print('Product not found in Firestore');
      }
    } catch (e) {
      // Error fetching product details
      print('Error fetching product details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (productSnapshot == null) {
      // If productSnapshot is null, return loading indicator
      return Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      // Display product details once fetched
      final productName = productSnapshot!['name'];
      final productPrice = productSnapshot!['price'];
      final productCondition = productSnapshot!['condition'];

      return Scaffold(
        appBar: AppBar(
          title: Text(productName),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image placeholder
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(
                      Icons.shopping_bag,
                      size: 50,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Display product details fetched from Firestore
              const Text(
                'Product Name:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                productName,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Price:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\RM$productPrice', // Format price as needed
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Condition:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                productCondition,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Add to cart functionality
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Add to Cart'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
