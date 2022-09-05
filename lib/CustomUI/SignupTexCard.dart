import 'package:flutter/material.dart';

import 'package:flutter_application_enviro_banking_application/AppTools/ConstPg.dart';


class SignupTex extends StatelessWidget {
  const SignupTex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      alignment: Alignment.topLeft,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: const Text("Sign-up with Enviro Banking",
        style: largeText,
        textAlign: TextAlign.start,
      ),
    );
    
  }
}