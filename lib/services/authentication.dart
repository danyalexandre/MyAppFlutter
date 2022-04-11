import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/models/user.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebase(User? user) {
    return user != null ? AppUser(user.uid) : null;
  }

  //Va écouter les modifications d'état sur l'utilisateur
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  //Sign In Email + Password
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register
  Future registerUser(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
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
