import 'package:flutter/material.dart';

import 'package:flutter_application_enviro_banking_application/AppTools/ConstPg.dart';


class SignInTex extends StatelessWidget {
  const SignInTex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      alignment: Alignment.topLeft,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: const Text("Welcome to Enviro Banking",
        style: largeText,
        textAlign: TextAlign.start,
      ),
    );
    
  }
}