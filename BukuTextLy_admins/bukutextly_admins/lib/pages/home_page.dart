import 'package:bukutextly_admins/components/product_box.dart';
import 'package:bukutextly_admins/pages/notif_page.dart';
import 'package:bukutextly_admins/pages/profile_page.dart';
//import 'package:bukutextly_admins/pages/shopping_page.dart';
import 'package:bukutextly_admins/utils/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> listOfPages = [
    HomePageContent(),
    const NotificationsPage(),
    //const ShoppingPage(),
    const ProfilePage(),
  ];

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF885A3A),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/chatspage');
            },
            icon: const Icon(
              Icons.chat_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFFC9B09A),
          child: ListView(
            children: [
              DrawerHeader(
                child: Image.asset(
                  'assets/logos/blacklogo.png',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          title: const Text('P R O F I L E'),
                          onTap: () {
                            Navigator.pushNamed(context, '/profilepage');
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.notifications_active,
                            color: Colors.black,
                          ),
                          title: const Text('N O T I F I C A T I O N S'),
                          onTap: () {
                            Navigator.pushNamed(context, '/notifpage');
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.settings,
                            color: Colors.black,
                          ),
                          title: const Text('S E T T I N G S'),
                          onTap: () {
                            Navigator.pushNamed(context, '/settingspage');
                          },
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey[300],
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.admin_panel_settings,
                            color: Colors.black,
                          ),
                          title: const Text('D A S H B O A R D'),
                          onTap: () {
                            Navigator.pushNamed(context, '/dashboardpage');
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.group,
                            color: Colors.black,
                          ),
                          title: const Text('U S E R L I S T'),
                          onTap: () {
                            Navigator.pushNamed(context, '/userslistpage');
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey[300],
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.logout_outlined,
                            color: Colors.black,
                          ),
                          title: const Text(
                            'Log Out',
                          ),
                          onTap: () {
                            print('Logging out...');
                            FirebaseAuth.instance.signOut().then((value) {
                              print('User signed out successfully');
                            }).catchError((error) {
                              print('Error signing out: $error');
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: listOfPages[selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(35),
          topEnd: Radius.circular(35),
        ),
        child: Container(
          color: const Color(0xFF885A3A),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            child: GNav(
              backgroundColor: const Color(0xFF885A3A),
              color: Colors.black,
              activeColor: Colors.white,
              tabBackgroundColor: const Color(0xFFA77D54),
              padding: const EdgeInsets.all(15),
              gap: 5,
              selectedIndex: selectedIndex,
              onTabChange: navigateBottomBar,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.notifications_active,
                  text: "Notif",
                ),
                //GButton(
                //  icon: Icons.shopping_cart,
                //  text: "Shop",
                //),
                GButton(
                  icon: Icons.person,
                  text: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  HomePageContent({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: SearchBar(
              hintText: 'Search',
            ),
          ),
        ),
        StreamBuilder<List<Product>>(
          stream: firestoreService.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasError) {
              return const SliverToBoxAdapter(
                child: Center(child: Text('Error loading products')),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const SliverToBoxAdapter(
                child: Center(child: Text('No products available')),
              );
            }

            final products = snapshot.data!;

            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = products[index];
                  return ProductBox(
                    productId: product.id,
                    productName: product.name,
                    productPrice: '\RM ${product.price.toStringAsFixed(2)}',
                    productCondition: product.condition,
                    imageUrl: product.imageUrl,
                  );
                },
                childCount: products.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.6,
              ),
            );
          },
        ),
      ],
    );
  }
}
