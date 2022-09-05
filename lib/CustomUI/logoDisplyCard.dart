import 'package:flutter/material.dart';

import 'package:flutter_application_enviro_banking_application/AppTools/ConstPg.dart';

class LogoDisply extends StatelessWidget {
  const LogoDisply({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /*return Container(
      width: 105.0,
      height: 105.0,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/logo.png"),
        fit: BoxFit.fill,
        ),
      ),
    );*/



    //double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[

            Icon(
              Icons.confirmation_number,
              color: chromeYel,
              size: 80,
            ),

            SizedBox(
              width: 2,
            ),

            Text(
              "Enviro Banking",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            )

          ],
        ),
      ),
    );

  }    
}