import 'package:flutter/material.dart';
import 'package:my_app/screens/home/home.dart';
import 'package:my_app/screens/login/login_page.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/widgets/widget.dart';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget {
  static const pageName = "/signup";
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static const Color backgroundTextField = Color.fromARGB(0, 255, 255, 255);
  static const Color colorTextField = Color.fromARGB(255, 255, 255, 255);
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  final pseudoController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RegExp pseudoRegExp = RegExp(r'^[a-zA-Z0-9]+$');
  String error = '';
  bool loading = false;

  @override
  void dispose() {
    pseudoController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Form(
            key: _formKey,
            child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  leading: BackButton(
                    onPressed: () {
                      //Navigator.pop(context);
                      Navigator.of(context).pushNamed(LoginPage.pageName);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        hintText: 'Pseudo',
                                        inputType: TextInputType.name,
                                        backgroundColor: backgroundTextField,
                                        textColor: colorTextField,
                                        controller: pseudoController,
                                        validator: (value) {
                                          if (value != null &&
                                              value.trim().length >= 4 &&
                                              pseudoRegExp.hasMatch(value)) {
                                            return null;
                                          } else {
                                            return 'Le champ pseudo doit être un alphanumérique de 4 caractères!';
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
                                              value != null ||
                                                      value!.trim().isEmpty
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
                                          if (value == null ||
                                              value.trim().isEmpty) {
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
                                            setState(() {
                                              loading = true;
                                              error = '';
                                            });
                                            final userExist =
                                                await _auth.doesUserExist(
                                                    pseudoController.value.text
                                                        .toLowerCase());
                                            if (!userExist) {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                var pseudo =
                                                    pseudoController.value.text;
                                                var email =
                                                    emailController.value.text;
                                                var password =
                                                    passwordController
                                                        .value.text;
                                                try {
                                                  dynamic result =
                                                      await _auth.registerUser(
                                                          pseudo,
                                                          email,
                                                          password);
                                                  if (result != null) {
                                                    setState(() {
                                                      loading = false;
                                                      Navigator.of(context)
                                                          .pushNamed(MyHomePage
                                                              .pageName);
                                                      error =
                                                          'Erreur lors de l\'enregistrement. Veuillez réssayer.';
                                                    });
                                                  }
                                                } catch (e) {
                                                  setState(() {
                                                    loading = false;
                                                    error = e.toString();
                                                  });
                                                }
                                              }
                                            } else {
                                              //Le pseudo existe déjà dans la bdd
                                              setState(() {
                                                loading = false;
                                                error =
                                                    'Ce pseudo est déjà utilisé.';
                                              });
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
