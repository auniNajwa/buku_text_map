import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get collection
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  //create

  //read
  Stream<QuerySnapshot> getUsersStream() {
    final usersStream = users.snapshots();

    return usersStream;
  }

  //update : by doc ID

  //delete : by doc ID
  Future<void> deleteNote(String docID) {
    return users.doc(docID).delete();
  }
}
