import 'package:bukutextly_users/components/features_box_widget.dart';
import 'package:bukutextly_users/components/item_box.widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //all users
  final usersCollection = FirebaseFirestore.instance.collection('Users');

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
                          left: 20.0,
                          right: 20.0,
                          bottom: 15.0,
                        ),
                        child: SizedBox(
                          height: 700, // Adjust the height as needed
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: 10,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                            itemBuilder: (context, index) {
                              return const ItemBoxWidget(
                                textInSquare: 'item description lorem ipsum',
                                iconData: Icons.favorite,
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error${snapshot.error}'),
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
