import 'package:flutter/material.dart';
import 'package:my_app/screens/login/login_page.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/widgets/my_button.dart';
import 'package:my_app/widgets/widget.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthenticationService _auth = AuthenticationService();
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Container(
            color: Colors.white,
            child: MyButton(
                buttonName: 'Déconnexion',
                onTap: () async {
                  try {
                    setState(() {
                      loading = true;
                      error = '';
                    });
                    await _auth.signOut();
                    //Déconnexion de l'utilisateur
                    setState(() {
                      loading = false;
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                      error = '';
                    });
                  } catch (e) {
                    setState(() {
                      loading = false;
                      error = e.toString();
                    });
                  }
                },
                bgColor: const Color(0xFF666bd3),
                textColor: Colors.white),
          );
  }
}
