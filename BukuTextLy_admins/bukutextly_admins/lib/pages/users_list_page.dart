import 'package:bukutextly_admins/helper/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getUsersStream(),
        builder: (context, snapshot) {
          //if have data, get all the users
          if (snapshot.hasData) {
            List usersList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                // Get individual document
                DocumentSnapshot document = usersList[index];
                String docID = document.id;

                // Get data from each document
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String userName = data['username'];

                // Display as a card
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(userName),
                    trailing: IconButton(
                      onPressed: () => firestoreService.deleteNote(docID),
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              },
            );
          }

          //if no users return nothing
          else {
            return const Text('There are no users . . . ');
          }
        },
      ),
    );
  }
}
