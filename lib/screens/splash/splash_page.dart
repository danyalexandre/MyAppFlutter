import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/screens/home/home.dart';
import 'package:my_app/screens/login/login_page.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    //Si l'utilisateur est déjà connecté on l'envoie sur la page d'accueil
    if (user != null) {
      return MyHomePage();
    }
    return const LoginPage();
  }
}
