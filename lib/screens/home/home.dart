import 'package:flutter/material.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/widgets/my_button.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: MyButton(
          buttonName: 'Déconnexion',
          onTap: () async {
            await _auth.signOut();
          },
          bgColor: const Color(0xFF666bd3),
          textColor: Colors.white),
    );
  }
}
