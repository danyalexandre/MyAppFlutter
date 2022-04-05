import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final logo = Container(
      /*decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
      ),*/ 
      height: 200,
      width: 200,
      child : ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: const Image(
            image: AssetImage('../assets/img/logo.jpeg'),
          ),
        ), 
      );

    //TextField de l'email
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const Icon(Icons.mail_outline_outlined)),
    );

    //TextField du password
    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Password',
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const Icon(Icons.key_sharp)),
    );

    final loginButton = ElevatedButton(
      child: const Text('Login'),
      onPressed: () {
        null;
      },
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          padding: const EdgeInsets.all(20.0),
          primary: Colors.orange,
          textStyle: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0))),
    );

    final forgotButton = TextButton(
      child: const Text(
        'Mot de passe oublié?',
        style: TextStyle(
          color: Colors.white
          ),
      ),
      onPressed: () {
        null;
      },
    );

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        
        child : Container(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        //child: ListView(
          //shrinkWrap: true,
          //padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            const SizedBox(height: 24.0),
            email,
            const SizedBox(height: 12.0),
            password,
            const SizedBox(height: 24.0),
            loginButton,
            const SizedBox(height: 24.0),
            forgotButton,
          ],
          ),
          ),
        ),
      //),
    );
  }
}
