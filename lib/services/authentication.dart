import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/database.dart';

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
      throw ("Les données de connexion sont fausses!");
    }
  }

  //Register
  Future registerUser(
      String prenom, String nom, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        await DatabaseService(user.uid).saveUser(prenom, nom, email);
        return _userFromFirebase(user);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        throw ("Le mot de passe fourni est trop faible.");
      } else if (e.code == 'email-already-in-use') {
        print(
            'An account already exists for that email address you are trying to sign up.');
        throw ("Un compte existe déjà pour cette adresse e-mail que vous essayez de vous inscrire.");
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
