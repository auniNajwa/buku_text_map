import 'package:bukutextly_admins/pages/product_details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductBox extends StatefulWidget {
  final String productId;
  final String productName;
  final String productPrice;
  final String productCondition;
  final String imageUrl;

  const ProductBox({
    super.key,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productCondition,
    required this.imageUrl,
  });

  @override
  State<ProductBox> createState() => _ProductBoxState();
}

class _ProductBoxState extends State<ProductBox> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                productId: widget.productId, // Pass userId
              ),
            ),
          );
        } else {
          // Handle case where user is not logged in
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('You need to be logged in to view product details')),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFFF95E5E),
                  borderRadius: BorderRadius.circular(20),
                  image: widget.imageUrl.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(widget.imageUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: widget.imageUrl.isEmpty
                    ? const Center(
                        child: Icon(Icons.image, size: 40, color: Colors.white))
                    : null,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.productName,
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        letterSpacing: 0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite
                          ? Colors.red
                          : Theme.of(context).primaryColor,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productPrice,
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        letterSpacing: 0,
                      ),
                    ),
                    Text(
                      widget.productCondition,
                      style: const TextStyle(
                          fontFamily: 'Manrope',
                          letterSpacing: 0,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
