// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/screens/splash/splash_page.dart';
import 'package:my_app/services/authentication.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBNa5n_gq84p0JZ2ynwaG3DY2Rgk_UApgE",
        authDomain: "lupiludi-6cfea.firebaseapp.com",
        projectId: "lupiludi-6cfea",
        storageBucket: "lupiludi-6cfea.appspot.com",
        messagingSenderId: "139759571374",
        appId: "1:139759571374:web:644484cc8d006dff94f83f",
        measurementId: "G-RK91BX7EFJ"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthenticationService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LoginPage',
        theme: ThemeData(
          fontFamily: 'Lato',
          appBarTheme: const AppBarTheme(
              color: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              titleTextStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
