import 'package:flutter/material.dart';
import 'package:my_app/login/sign_up_page.dart';
import 'package:my_app/widgets/widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
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

    //TextField de l'email
    final email = Container(
      decoration: BoxDecoration(
        color: const Color(0xfff1f1f5),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: TextFormField(
        cursorColor: const Color(0xFF666bd3),
        decoration: InputDecoration(
          hintText: 'Email',
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff94959b),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: IconButton(
            color: const Color(0xFF666bd3),
            splashRadius: 1,
            onPressed: () => {},
            icon: const Icon(Icons.mail_outlined),
          ),
        ),
      ),
    );

    //TextField du password
    final password = Container(
      decoration: BoxDecoration(
        color: const Color(0xfff1f1f5),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: TextFormField(
        cursorColor: const Color(0xFF666bd3),
        obscureText: !passwordVisible,
        decoration: InputDecoration(
          hintText: 'Mot de passe',
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff94959b),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: IconButton(
            color: const Color(0xFF666bd3),
            splashRadius: 1,
            onPressed: togglePassword,
            icon: Icon(passwordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined),
          ),
        ),
      ),
    );

    final loginButton = ElevatedButton(
      child: const Text('Connexion'),
      onPressed: () {
        null;
      },
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          padding: const EdgeInsets.all(20.0),
          primary: const Color(0xFF666bd3),
          textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0))),
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
      body: Center(
        child: Container(
          /*decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.black, Color.fromARGB(255, 87, 87, 87)])),*/
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              logo,
              const SizedBox(height: 36.0),
              const MyTextField(
                hintText: 'Email',
                inputType: TextInputType.name,
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                textColor: Color.fromARGB(255, 0, 0, 0),
              ),
              const MyPasswordField(
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                textColor: Color.fromARGB(255, 0, 0, 0),
              ),
              const SizedBox(height: 24.0),
              loginButton,
              const SizedBox(height: 24.0),
              forgotButton,
              const SizedBox(height: 24.0),
              registerButton,
            ],
          ),
        ),
      ),
    );
  }
}
