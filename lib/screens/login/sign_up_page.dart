import 'package:flutter/material.dart';
import 'package:my_app/widgets/widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static const Color backgroundTextField = Color.fromARGB(0, 255, 255, 255);
  static const Color colorTextField = Color.fromARGB(255, 255, 255, 255);
  final _formKey = GlobalKey<FormState>();
  final prenomController = TextEditingController();
  final nomController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
    return Scaffold(
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
                                  return '';
                                },
                              ),
                              MyTextField(
                                hintText: 'Nom',
                                inputType: TextInputType.name,
                                backgroundColor: backgroundTextField,
                                textColor: colorTextField,
                                controller: nomController,
                                validator: (value) {
                                  return '';
                                },
                              ),
                              MyTextField(
                                hintText: 'Email',
                                inputType: TextInputType.name,
                                backgroundColor: backgroundTextField,
                                textColor: colorTextField,
                                controller: emailController,
                                validator: (value) {
                                  return '';
                                },
                              ),
                              MyPasswordField(
                                backgroundColor: backgroundTextField,
                                textColor: colorTextField,
                                controller: passwordController,
                                validator: (value) {
                                  return '';
                                },
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: MyButton(
                            buttonName: 'Créer mon compte',
                            onTap: () {},
                            bgColor: Colors.white,
                            textColor: Colors.black87),
                      ),
                    ],
                  ),
                ),
              )
            ],
            /*child: Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Inscription',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Créer votre compte pour utiliser l\'application',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SizedBox(height: 24.0),
                  MyTextField(
                    hintText: 'Prénom',
                    inputType: TextInputType.name,
                    backgroundColor: backgroundTextField,
                    textColor: colorTextField,
                  ),
                  MyTextField(
                    hintText: 'Nom',
                    inputType: TextInputType.name,
                    backgroundColor: backgroundTextField,
                    textColor: colorTextField,
                  ),
                  MyTextField(
                    hintText: 'Email',
                    inputType: TextInputType.name,
                    backgroundColor: backgroundTextField,
                    textColor: colorTextField,
                  ),
                  MyPasswordField(
                    backgroundColor: backgroundTextField,
                    textColor: colorTextField,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MyButton(
                        buttonName: 'Créer mon compte',
                        onTap: null,
                        bgColor: Colors.white,
                        textColor: Colors.black87),
                  )
                ],
              ),
            ),*/
          ),
        ));
  }
}
