import 'package:bukutextly_users/components/text_boxt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //all users
  final usersCollection = FirebaseFirestore.instance.collection('Users');

  //edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.brown[700],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          cursorColor: Colors.brown[200],
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.grey[400]),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFC9B09A)),
            ),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          //cancle button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),

          //save button
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    //update in firestore database
    if (newValue.trim().isNotEmpty) {
      //update when only ada update
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          //get user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.brown[300],
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 73,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                //user email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),

                //user details
                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'My Details',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),

                //username
                MyTextBox(
                  text: userData['username'],
                  sectionName: 'Username',
                  onPressed: () => editField('username'),
                ),

                //first name
                MyTextBox(
                  text: userData['first_name'],
                  sectionName: 'First Name',
                  onPressed: () => editField('first_name'),
                ),

                //last name
                MyTextBox(
                  text: userData['last_name'],
                  sectionName: 'Last name',
                  onPressed: () => editField('last_name'),
                ),

                //bio
                MyTextBox(
                  text: userData['bio'],
                  sectionName: 'Bio',
                  onPressed: () => editField('bio'),
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
    );
  }
}
