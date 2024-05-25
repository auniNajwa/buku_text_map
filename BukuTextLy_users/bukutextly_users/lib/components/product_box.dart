import 'package:flutter/material.dart';

class ProductBox extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String productCondition;

  const ProductBox({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productCondition,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
