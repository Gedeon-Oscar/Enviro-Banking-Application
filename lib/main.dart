import 'package:flutter/material.dart';

import 'package:flutter_application_enviro_banking_application/Srceens/SplashPg.dart';
import 'package:flutter_application_enviro_banking_application/Srceens/SignIn.dart';
import 'package:flutter_application_enviro_banking_application/Srceens/SignUp.dart';
import 'package:flutter_application_enviro_banking_application/Srceens/LoanSreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enviro Banking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const SplashPg(),
        'SignIn': (context) => SignIn(),
        'SignUp': (context) =>  const SignUp(),
        'LoanSreen': (context) =>  const LoanSreen(),
      }
    );
  }
}
