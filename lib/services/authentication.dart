import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/database.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _dataBase = FirebaseFirestore.instance;

  //Sign In Email + Password
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //User? user = result.user;
      //return _userFromFirebase(user);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      throw ("Les données de connexion sont fausses!");
    }
  }

  Future<bool> doesUserExist(currentUserName) async {
    try {
      //Retourne Vrai si le username existe dans la base
      final result = await _dataBase
          .collection('users')
          .where('pseudo', isEqualTo: currentUserName)
          .get();
      return result.docs.isNotEmpty;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //Register
  Future registerUser(String pseudo, String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user != null) {
          //Stockage des informations de l'utilisateur dans la collection "Users"
          _dataBase
              .collection("users")
              .doc(value.user?.uid)
              .set({"email": email, "pseudo": pseudo});
        } else {
          return false;
        }
      });
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        throw ("Le mot de passe fourni est trop faible.");
      } else if (e.code == 'email-already-in-use') {
        print(
            'An account already exists for that email address you are trying to sign up.');
        throw ("Un compte existe déjà pour cette adresse e-mail que vous essayez de vous inscrire.");
      } else {
        print(e.code);
        throw (e.code);
      }
    } catch (e) {
      print("Exception thrown on Sign Up page");
    }
  }

  //Sing out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }
}
