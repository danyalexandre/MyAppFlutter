import 'package:flutter/material.dart';
import 'package:my_app/screens/home/home.dart';
import 'package:my_app/screens/login/sign_up_page.dart';
import 'package:my_app/widgets/widget.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';
import 'package:my_app/services/authentication.dart';

class LoginPage extends StatefulWidget {
  static const pageName = "/login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String error = '';
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Container(
      /*decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
      ),*/
      height: 200,
      width: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: const Image(
          image: AssetImage('../assets/img/logo.jpeg'),
        ),
      ),
    );

    final forgotButton = TextButton(
      child: const Text(
        'Mot de passe oublié?',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        null;
      },
    );

    final registerButton = Container(
      child: Column(
        children: [
          const Text(
            'Pas encore de compte ?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          TextButton(
            child: const Text(
              'S\'inscrire',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(SignUp.pageName);
            },
          ),
        ],
      ),
    );

    return loading
        ? const Loading()
        : Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("./../assets/img/fond.jpeg"),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Form(
                key: _formKey,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        logo,
                        const SizedBox(height: 36.0),
                        MyTextField(
                          hintText: 'Email',
                          inputType: TextInputType.emailAddress,
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          textColor: Color.fromARGB(255, 0, 0, 0),
                          controller: emailController,
                          validator: (value) {
                            if (!EmailValidator.validate(
                                value != null || value!.trim().isEmpty
                                    ? value.trim()
                                    : '')) {
                              return 'Entrer une adresse mail valide';
                            }
                            return null;
                          },
                        ),
                        MyPasswordField(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          textColor: const Color.fromARGB(255, 0, 0, 0),
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Ce champ est obligatoire';
                            }
                            if (value.trim().length < 8) {
                              return 'Le mot de passe doit contenir plus de 8 charactère!';
                            }
                            // Return null if the entered password is valid
                            return null;
                          },
                        ),
                        const SizedBox(height: 24.0),
                        MyButton(
                            buttonName: 'Login',
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                var email = emailController.value.text;
                                var password = passwordController.value.text;
                                try {
                                  setState(() {
                                    loading = true;
                                    error = '';
                                  });
                                  dynamic result =
                                      await _auth.signIn(email, password);
                                  setState(() {
                                    loading = false;
                                  });
                                  //La connexion a réussi
                                  if (result != null) {
                                    /*Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => MyHomePage()),
                                    );*/
                                    Navigator.of(context)
                                        .pushNamed(MyHomePage.pageName);
                                  } else {
                                    error =
                                        'Un soucis a eu lieu pendant la connexion. Veuillez réssayer.';
                                  }
                                } catch (e) {
                                  setState(() {
                                    loading = false;
                                    error = e.toString();
                                  });
                                }
                              }
                            },
                            bgColor: const Color(0xFF666bd3),
                            textColor: Colors.white),
                        const SizedBox(height: 10.0),
                        Text(
                          error,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 18.0),
                        ),
                        const SizedBox(height: 24.0),
                        forgotButton,
                        const SizedBox(height: 24.0),
                        registerButton,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
