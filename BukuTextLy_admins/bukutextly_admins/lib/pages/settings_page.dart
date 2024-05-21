import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10.0),
            const Text(
              "Settings And Privacy",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading:
                        const Icon(Icons.person_outline, color: Colors.black),
                    title: const Text("Edit Profile"),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pushNamed(context, '/editprofilepage');
                      //PERGI EDIT PROFILE
                    },
                  ),
                  buildDivider(),
                  ListTile(
                    leading:
                        const Icon(Icons.lock_outline, color: Colors.black),
                    title: const Text("Change Password"),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pushNamed(context, '**');
                      //PERGI
                    },
                  ),
                  buildDivider(),
                  ListTile(
                    leading: const Icon(Icons.notifications_outlined,
                        color: Colors.black),
                    title: const Text("Notifications"),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pushNamed(context, '**');
                      //PERGI
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              "Help and Support",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.live_help_outlined,
                        color: Colors.black),
                    title: const Text("Help Center"),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pushNamed(context, '**');
                      //PERGI
                    },
                  ),
                  buildDivider(),
                  ListTile(
                    leading: const Icon(Icons.contact_mail_outlined,
                        color: Colors.black),
                    title: const Text("Contact Us"),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pushNamed(context, '**');
                      //PERGI
                    },
                  ),
                  buildDivider(),
                  ListTile(
                    leading:
                        const Icon(Icons.info_outline, color: Colors.black),
                    title: const Text("About Us"),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pushNamed(context, '**');
                      //PERGI
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              "Logout",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading:
                        const Icon(Icons.person_outline, color: Colors.black),
                    title: const Text("Logout"),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                      //PERGI EDIT PROFILE
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
