import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:bukutextly_users/components/product_box_widget.dart';
import 'package:bukutextly_users/components/features_box_widget.dart';
import 'package:bukutextly_users/helper/firestore_services.dart';
import 'package:bukutextly_users/components/item_box.widget.dart'; // Import necessary widgets

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  final FirestoreService firestoreService =
      FirestoreService(); // Firestore service instance

  //rating value
  double ratingValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            //get user data
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      //profile picture
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //profile picture
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              width: 100, // Adjust size as needed
                              height: 100, // Adjust size as needed
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.brown[
                                    300], // Choose your desired background color
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 73,
                              ),
                            ),
                          ),

                          //user's name
                          Text(
                            userData['first_name'] +
                                ' ' +
                                userData['last_name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 20.0,
                            ),
                          ),

                          //settings
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/settingspage');
                              },
                              icon: const Icon(
                                Icons.settings,
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),

                      //username
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 50.0,
                        ),
                        child: Text(
                          '@' + userData['username'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 15.0,
                          ),
                        ),
                      ),

                      //rating thingy
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 10),
                        child: Row(
                          children: [
                            RatingBar.builder(
                              initialRating: ratingValue,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              itemSize: 25,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star_rate_rounded,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  ratingValue = rating;
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            Text(
                              ratingValue
                                  .toString(), // Display the rating value as a string
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Featurs box
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                        child: SizedBox(
                          height: 100,
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FeaturesBoxWidget(
                                  icon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.star_border_rounded),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      //search bar
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SearchBar(
                          hintText: 'Search',
                        ),
                      ),

                      //item listing
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 15.0,
                          right: 15.0,
                          bottom: 15.0,
                        ),
                        child: StreamBuilder<List<ProductWithID>>(
                          stream: firestoreService.getProducts(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Error loading products'));
                            }

                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(
                                  child: Text('No products available'));
                            }

                            final products = snapshot.data!;

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: products.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio:
                                    0.65, // Adjust this ratio to fit your content
                              ),
                              padding: const EdgeInsets.all(
                                  8), // Add padding to the grid
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return ProductBox(
                                  productId: product.id,
                                  productName: product.name,
                                  productPrice:
                                      '\RM${product.price.toStringAsFixed(2)}',
                                  productCondition: product.condition,
                                );
                              },
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
