import 'package:flutter/material.dart';
import 'package:my_app/login/sign_up_page.dart';
import 'package:my_app/widgets/widget.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SignUp();
              }));
            },
          ),
        ],
      ),
    );

    return Scaffold(
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
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  textColor: Color.fromARGB(255, 0, 0, 0),
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
                    onTap: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    bgColor: Color(0xFF666bd3),
                    textColor: Colors.white),
                const SizedBox(height: 24.0),
                forgotButton,
                const SizedBox(height: 24.0),
                registerButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
