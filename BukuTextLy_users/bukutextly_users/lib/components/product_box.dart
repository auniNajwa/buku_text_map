import 'package:bukutextly_users/pages/product_details_page.dart';
import 'package:flutter/material.dart';

class ProductBox extends StatelessWidget {
  final String productId;
  final String productName;
  final String productPrice;
  final String productCondition;
  final String imageUrl;

  const ProductBox({
    super.key,
    required this.productId, // Add productId
    required this.productName,
    required this.productPrice,
    required this.productCondition,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              productId: productId, // Pass productId
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
                  image: imageUrl.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: imageUrl.isEmpty
                    ? Center(
                        child: Icon(Icons.image, size: 40, color: Colors.white))
                    : null,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      productName,
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        letterSpacing: 0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productPrice,
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        letterSpacing: 0,
                      ),
                    ),
                    Text(
                      productCondition,
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        letterSpacing: 0,
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
