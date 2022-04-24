import 'package:flutter/material.dart';
import 'package:my_app/screens/home/home.dart';
import 'package:my_app/screens/login/login_page.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/widgets/widget.dart';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static const Color backgroundTextField = Color.fromARGB(0, 255, 255, 255);
  static const Color colorTextField = Color.fromARGB(255, 255, 255, 255);
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  final prenomController = TextEditingController();
  final nomController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RegExp nameRegExp = RegExp(r'^[a-z A-Z]+$');
  String error = '';
  bool loading = false;

  @override
  void dispose() {
    prenomController.dispose();
    nomController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: const Color(0xff191720),
          body: SafeArea(
            child: CustomScrollView(
              reverse: true,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                            fit: FlexFit.loose,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Inscription',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                const Text(
                                  'Créer votre compte pour utiliser l\'application',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 24.0),
                                MyTextField(
                                  hintText: 'Prénom',
                                  inputType: TextInputType.name,
                                  backgroundColor: backgroundTextField,
                                  textColor: colorTextField,
                                  controller: prenomController,
                                  validator: (value) {
                                    if (value != null &&
                                        value.trim().length >= 2 &&
                                        nameRegExp.hasMatch(value)) {
                                      return null;
                                    } else {
                                      return 'Le champ prénom est incorrect!';
                                    }
                                  },
                                ),
                                MyTextField(
                                  hintText: 'Nom',
                                  inputType: TextInputType.name,
                                  backgroundColor: backgroundTextField,
                                  textColor: colorTextField,
                                  controller: nomController,
                                  validator: (value) {
                                    if (value != null &&
                                        value.trim().length >= 2 &&
                                        nameRegExp.hasMatch(value)) {
                                      return null;
                                    } else {
                                      return 'Le champ nom est incorrect!';
                                    }
                                  },
                                ),
                                MyTextField(
                                  hintText: 'Email',
                                  inputType: TextInputType.name,
                                  backgroundColor: backgroundTextField,
                                  textColor: colorTextField,
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
                                  backgroundColor: backgroundTextField,
                                  textColor: colorTextField,
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
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: Column(
                              children: [
                                Text(
                                  error,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 18.0),
                                ),
                                const SizedBox(height: 24.0),
                                MyButton(
                                    buttonName: 'Créer mon compte',
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        var prenom =
                                            prenomController.value.text;
                                        var nom = nomController.value.text;
                                        var email = emailController.value.text;
                                        var password =
                                            passwordController.value.text;
                                        try {
                                          setState(() {
                                            loading = true;
                                            error = '';
                                          });
                                          dynamic result =
                                              await _auth.registerUser(
                                                  prenom, nom, email, password);
                                          if (result != null) {
                                            setState(() {
                                              loading = false;
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginPage()),
                                              );
                                              /*error =
                                                  'Erreur lors de l\'enregistrement. Veuillez réssayer.';*/
                                            });
                                          }
                                        } catch (e) {
                                          setState(() {
                                            loading = false;
                                            error = e.toString();
                                          });
                                        }
                                      }
                                    },
                                    bgColor: Colors.white,
                                    textColor: Colors.black87),
                              ],
                            )
                            /*child: MyButton(
                              buttonName: 'Créer mon compte',
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  var prenom = prenomController.value.text;
                                  var nom = nomController.value.text;
                                  var email = emailController.value.text;
                                  var password = passwordController.value.text;
                                  //try {
                                  setState(() {
                                    loading = true;
                                    error = '';
                                  });
                                  dynamic result = await _auth.registerUser(
                                      prenom, nom, email, password);
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error =
                                          'Erreur lors de l\'enregistrement. Veuillez réssayer.';
                                    });
                                  } else {
                                    Navigator.pop(context);
                                  }
                                  /*} catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(e.toString()),
                                      ),
                                    );
                                  }*/
                                }
                              },
                              bgColor: Colors.white,
                              textColor: Colors.black87),*/
                            ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
