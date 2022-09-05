import 'package:flutter/material.dart';

import 'package:flutter_application_enviro_banking_application/Srceens/SignIn.dart';
import 'package:flutter_application_enviro_banking_application/AppTools/ConstPg.dart';


class SplashPg extends StatefulWidget {
  const SplashPg({Key? key}) : super(key: key);

  @override
  State<SplashPg> createState() => _SplashPgState();
}

class _SplashPgState extends State<SplashPg> {

  @override
  void initState(){
    super.initState();
    _navigatToSignIn();
  }

  _navigatToSignIn() async{
    await Future.delayed( const Duration( seconds: 10 ), ()  {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn() ));
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: navyBlu,
      body: Center(
        child: Container(
          color: Colors.transparent,
          //padding: EdgeInsetsGeometry.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
    
              Icon(
                Icons.confirmation_number,
                color: chromeYel,
                size: 100,
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
      ),
    );
  }
}