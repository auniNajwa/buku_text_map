import 'package:bukutextly_users/components/product_box_widget.dart';
import 'package:bukutextly_users/helper/firestore_services.dart';
import 'package:bukutextly_users/pages/notif_page.dart';
import 'package:bukutextly_users/pages/profile_page.dart';
import 'package:bukutextly_users/pages/shopping_page.dart';
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
    const HomePageContent(),
    const NotificationsPage(),
    const ShoppingPage(),
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
                        Icons.trolley,
                        color: Colors.black,
                      ),
                      title: const Text('C A R T'),
                      onTap: () {
                        Navigator.pushNamed(context, '/shoppingpage');
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.shopping_bag_sharp,
                        color: Colors.black,
                      ),
                      title: const Text('M A R K E T'),
                      onTap: () {
                        Navigator.pushNamed(context, '/shoppingpage');
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
                    ListTile(
                      leading: const Icon(
                        Icons.add_box_rounded,
                        color: Colors.black,
                      ),
                      title: const Text('ADD PRODUCT'),
                      onTap: () {
                        Navigator.pushNamed(context, '/addproductpage');
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 220,
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
                  FirebaseAuth.instance.signOut();
                },
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
                GButton(
                  icon: Icons.shopping_cart,
                  text: "Shop",
                ),
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

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController searchController = TextEditingController();
  late List<ProductWithID> allProducts;
  List<ProductWithID> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      allProducts = await firestoreService.getAllProducts();
      setState(() {
        filteredProducts = allProducts;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void filterProducts(String query) {
    final List<ProductWithID> filteredList = allProducts.where((product) {
      final productName = product.name.toLowerCase();
      return productName.contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredProducts = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onChanged: (value) {
              filterProducts(value);
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
              left: 10.0,
              right: 10.0,
              bottom: 10.0,
            ),
            child: StreamBuilder<List<ProductWithID>>(
              stream: firestoreService.getProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading products'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products available'));
                }

                final products = snapshot.data!;

                return SingleChildScrollView(
                  child: GridView.builder(
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
                    padding: const EdgeInsets.all(8), // Add padding to the grid
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductBox(
                        productId: product.id,
                        productName: product.name,
                        productPrice: '\RM${product.price.toStringAsFixed(2)}',
                        productCondition: product.condition,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
