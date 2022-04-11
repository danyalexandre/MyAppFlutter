import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> saveUser(String prenom, String nom, String email) async {
    return await userCollection
        .doc(uid)
        .set({'prenom': prenom, 'nom': nom, 'email': email});
  }
}
