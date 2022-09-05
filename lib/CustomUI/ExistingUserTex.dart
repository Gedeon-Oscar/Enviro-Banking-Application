import 'package:flutter/material.dart';

import 'package:flutter_application_enviro_banking_application/AppTools/ConstPg.dart';

import 'package:flutter_application_enviro_banking_application/Srceens/SignIn.dart';

class ExistingUserTex extends StatelessWidget {
  const ExistingUserTex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                                                    
            const Text("Already have an account? ",
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
              ),
            ),

            GestureDetector(
              onTap: (){
                // navigating to sign-in page
                Navigator.push(context, MaterialPageRoute( builder: (context) => SignIn() ));
              },
              child: const Text("SignIn",
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w700,
                  color: chromeYel,
                ),
              ),
            ),

          ],
        ),
      ),
    );
    
  }
}