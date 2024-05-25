import 'package:bukutextly_users/components/circular_icon.dart';
import 'package:bukutextly_users/components/product_title_text.dart';
import 'package:bukutextly_users/components/rounded_container.dart';
import 'package:bukutextly_users/components/rounded_image.dart';
import 'package:bukutextly_users/utils/shadows.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: [ShadowStlye.horizontalProductShadow],
          borderRadius: BorderRadius.circular(17.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            //Thumbnail, WishList button
            const RoundedContainer(
              height: 120,
              padding: EdgeInsets.all(5),
              backgroundColor: Colors.black12,
              child: Stack(
                children: [
                  //thumbnail image
                  RoundedImage(
                    imageUrl: 'assets/images/imageplaceholder.png',
                    applyImageRadius: true,
                  ),

                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircularIcon(
                      icon: Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),

            //Product details

            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProductTitleText(
                    title: 'Introduction to Computer Science',
                    smallSize: true,
                  ),
                  const Text(
                    'Condition',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //price
                      const Text(
                        '\$35.6',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),

                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: const SizedBox(
                          width: 34,
                          height: 34,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
