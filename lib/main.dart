import 'package:flutter/material.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/login/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: const Center(
        child: Text(
          'Welcome in MyApp',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black87,
          ),
        ),
      ),
      /*debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      //home: AuthScreen(),
      home: Scaffold(
        body: const Center(
          child: Text(
            'Welcome in MyApp',
            style: TextStyle(
              color: kPrimaryLightColor,
            ),
          ),
        ),
      ),*/
    );
  }
}
