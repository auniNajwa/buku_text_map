import 'package:bukutextly_users/pages/product_detail.dart';
import 'package:flutter/material.dart';

class ProductBox extends StatefulWidget {
  final String productId; // Add productId property
  final String productName;
  final String productPrice;
  final String productCondition;

  const ProductBox({
    super.key,
    required this.productId, // Initialize productId property
    required this.productName,
    required this.productPrice,
    required this.productCondition,
  });

  @override
  State<ProductBox> createState() => _ProductBoxState();
}

class _ProductBoxState extends State<ProductBox> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the new page and pass the product ID
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              productId: widget.productId, // Pass productId
            ),
          ),
        );
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
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFF95E5E),
                  borderRadius: BorderRadius.circular(20),
                ),
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
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited
                          ? Colors.red
                          : Theme.of(context).primaryColor,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorited = !isFavorited;
                      });
                    },
                  ),
                ], // Add this closing bracket
              ), // Add this closing bracket
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        color: Colors.grey,
                      ),
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
