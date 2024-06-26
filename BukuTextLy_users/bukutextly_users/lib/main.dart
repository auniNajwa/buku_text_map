import 'package:bukutextly_users/auth/main_page.dart';
import 'package:bukutextly_users/firebase_options.dart';
import 'package:bukutextly_users/pages/add_product_page.dart';
import 'package:bukutextly_users/pages/cart_page.dart';
import 'package:bukutextly_users/pages/chats_page.dart';
import 'package:bukutextly_users/pages/edit_profile_page.dart';
import 'package:bukutextly_users/pages/home_page.dart';
import 'package:bukutextly_users/pages/notif_page.dart';
import 'package:bukutextly_users/pages/profile_page.dart';
import 'package:bukutextly_users/pages/report_page.dart';
import 'package:bukutextly_users/pages/settings_page.dart';
import 'package:bukutextly_users/pages/shopping_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //must put this
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      routes: {
        '/mainpage': (context) => const MainPage(),
        '/profilepage': (context) => const ProfilePage(),
        '/homepage': (context) => const HomePage(),
        '/shoppingpage': (context) => const ShoppingPage(),
        '/notifpage': (context) => const NotificationsPage(),
        '/settingspage': (context) => const SettingsPage(),
        '/chatspage': (context) => const ChatsPage(),
        '/editprofilepage': (context) => const EditProfilePage(),
        '/addproductpage': (context) => const AddProductPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/reports') {
          final args = settings.arguments as ReportsPageArguments;
          return MaterialPageRoute(
            builder: (context) {
              return ReportsPage(
                userUsername: args.userUsername,
                date: args.date,
                totalListings: args.totalListings,
              );
            },
          );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}

class ReportsPageArguments {
  final String userUsername;
  final String date;
  final int totalListings;

  ReportsPageArguments({
    required this.userUsername,
    required this.date,
    required this.totalListings,
  });
}
