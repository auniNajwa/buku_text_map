import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:bukutextly_users/utils/firestore_service.dart';
import 'package:bukutextly_users/components/features_box_widget.dart';
import 'package:bukutextly_users/components/product_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //rating value
  double ratingValue = 0;

  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(currentUser.email)
                          .snapshots(),
                      builder: (context, snapshot) {
                        // Check for data
                        if (snapshot.hasData) {
                          // Ensure the data is not null
                          final data = snapshot.data!.data();
                          if (data != null) {
                            final userData = data as Map<String, dynamic>;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                //profile picture
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //profile picture
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
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
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/settingspage');
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
                                  padding: const EdgeInsets.only(
                                      left: 30.0, top: 10),
                                  child: Row(
                                    children: [
                                      RatingBar.builder(
                                        initialRating: ratingValue,
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        itemSize: 25,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star_rate_rounded,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
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
                                              icon: const Icon(
                                                  Icons.star_border_rounded),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                //search bar
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                    controller: _searchController,
                                    decoration: const InputDecoration(
                                      hintText: 'Search',
                                      prefixIcon: Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                    ),
                                  ),
                                ),

                                // Tab Bar
                                TabBar(
                                  indicatorColor: Colors.blue,
                                  labelColor: Colors.blue,
                                  unselectedLabelColor: Colors.grey,
                                  tabs: [
                                    Tab(text: 'Products'),
                                    Tab(text: 'Reviews'),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                              child: Text('User data not found'),
                            );
                          }
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
                  SliverFillRemaining(
                    child: TabBarView(
                      children: [
                        // Products Tab
                        StreamBuilder<List<Product>>(
                          stream: firestoreService.getProducts(
                              searchQuery: _searchQuery),
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
                              padding: const EdgeInsets.all(10.0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.6,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return ProductBox(
                                  productId: product.id,
                                  productName: product.name,
                                  productPrice:
                                      '\RM ${product.price.toStringAsFixed(2)}',
                                  productCondition: product.condition,
                                  imageUrl: product.imageUrl,
                                );
                              },
                            );
                          },
                        ),
                        // Reviews Tab
                        Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 0, 0),
                                ),
                              ),
                              // Add your reviews content here
                            ],
                          ),
                        ),
                      ],
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
