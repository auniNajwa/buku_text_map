import 'package:bukutextly_admins/auth/main_page.dart';
import 'package:bukutextly_admins/auth/onboarding_page.dart';
import 'package:bukutextly_admins/firebase_options.dart';
import 'package:bukutextly_admins/pages/chats_page.dart';
import 'package:bukutextly_admins/pages/dashboard_page.dart';
import 'package:bukutextly_admins/pages/edit_profile_page.dart';
import 'package:bukutextly_admins/pages/home_page.dart';
import 'package:bukutextly_admins/pages/notif_page.dart';
import 'package:bukutextly_admins/pages/profile_page.dart';
import 'package:bukutextly_admins/pages/reports_page.dart';
import 'package:bukutextly_admins/pages/settings_page.dart';
import 'package:bukutextly_admins/pages/shopping_page.dart';
import 'package:bukutextly_admins/pages/users_list_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        '/onboardingpage': (context) => const OnboardingPage(),
        '/mainpage': (context) => const MainPage(),
        '/profilepage': (context) => const ProfilePage(),
        '/homepage': (context) => const HomePage(),
        '/shoppingpage': (context) => const ShoppingPage(),
        '/notifpage': (context) => const NotificationsPage(),
        '/settingspage': (context) => const Settingspage(),
        '/chatspage': (context) => const ChatsPage(),
        '/editprofilepage': (context) => const EditProfilePage(),
        '/userslistpage': (context) => const UsersListPage(),
        '/dashboardpage': (context) => const DashboardPage(),
        //'/reports': (context) => const ReportsPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/reports') {
          final args = settings.arguments as ReportsPageArguments;
          return MaterialPageRoute(
            builder: (context) {
              return ReportsPage(
                adminUsername: args.adminUsername,
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
  final String adminUsername;
  final String date;
  final int totalListings;

  ReportsPageArguments({
    required this.adminUsername,
    required this.date,
    required this.totalListings,
  });
}
