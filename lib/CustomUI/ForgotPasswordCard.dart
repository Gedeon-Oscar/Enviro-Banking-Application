import 'package:flutter/material.dart';


class ForgotPasswordCard extends StatelessWidget {
  const ForgotPasswordCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: const Text("Lost your password?",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 15.0,
          ),
        ),
      ),
    );
    
  }
}