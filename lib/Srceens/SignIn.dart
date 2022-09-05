// main(root) application import
import 'package:flutter/material.dart';
// flutter dependence(s)
import 'package:http/http.dart' as http;
import 'dart:convert';
// application tools import(s)
import 'package:flutter_application_enviro_banking_application/AppTools/ConstPg.dart';
import 'package:flutter_application_enviro_banking_application/AppTools/Progressor.dart';
import 'package:flutter_application_enviro_banking_application/AppTools/Constants.dart';
// custom ui import(s)
import 'package:flutter_application_enviro_banking_application/CustomUI/CreatingUserTex.dart';
import 'package:flutter_application_enviro_banking_application/CustomUI/SignInTexCard.dart';
import 'package:flutter_application_enviro_banking_application/CustomUI/logoDisplyCard.dart';
// application srceen(s)
import 'package:flutter_application_enviro_banking_application/Srceens/LoanSreen.dart';
// application model(s)
import 'package:flutter_application_enviro_banking_application/Model/UserModel.dart';
import 'package:flutter_application_enviro_banking_application/Model/VaildationResponseModel.dart';
import 'package:flutter_application_enviro_banking_application/Model/TokenModel.dart';


class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  // initialing and declarating the User model form UserModel.dart
  User user = User();
  // initialing and declarating the User model form VaildationResponse.dart
  VaildationResponse vaildationResponse = VaildationResponse();
  // initialing and declarating the User model form VaildationResponse.dart
  Token token = Token();
  // initialing and declarating the global Form key
  final GlobalKey<FormState> signinExistingUserForm = GlobalKey<FormState>();
  // creating a TextEditingController
  final TextEditingController _exUserEmail = TextEditingController();
  // creating a TextEditingController
  final TextEditingController _exUserPassword = TextEditingController();

  // dispose TextEditingController when the widget is unmounted  //NB why
  @override
  void dispose(){
    _exUserEmail.dispose();
    _exUserPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _exUserEmail.text;
    _exUserPassword.text;

    super.initState();
  }

  // initialing and declarating password to be obscure
  bool _obscureText = true;
  // toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // http post-reuesit 
  Future<void> signMeIn( ) async {
    // testing: id:201, endpoint:https://jsonplaceholder.typicode.com/posts

    // creating the User,VaildationResponse class instance inside of the signMeIn method
    user = User( emailAddress: _exUserEmail.text, password: _exUserPassword.text );
    vaildationResponse = VaildationResponse();
    token = Token();

    var url = Uri.parse(ApiConstSignIn.baseUrl + ApiConstSignIn.usersEndpoint);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // the User model
      body: json.encode( user.toJson() ),
    );
    if( response.Code == 200 ){
      var jsondata = json.decode(response.body);
      //print( jsondata );
      // if the data is successfully posted

      //[1] get JWT token via api call
      setState(() {
        Token(
          jwt: jsondata,
        ).toJson();
      });
      //[2] navigate user to the loan service srceen
      Navigator.push(context, MaterialPageRoute( builder: (context) => const LoanSreen() ));
      //[3] VaildationResponse
      print(
        json.encode(
          VaildationResponse(
          errors: '',
          success: true,
          warnings: '',
          ).toJson()
        )
      );

    }else{

      print(
        json.encode(
          VaildationResponse(
          errors: '',
          success: false,
          warnings: '',
          ).toJson()
        )
      );
      
    }
  }
  
  // declarating boolean variable for the control of the the progress indicator
  bool isApiProcess = false;
  // modifying the build method as it describes the user interface represented by the Progressor widget.
  @override
  Widget build(BuildContext context) {
    return Progressor(
      child: _uiSetUp(context),
      inAsyncCall: isApiProcess,
      opacity: 0.3
    );
  }

  Widget _uiSetUp(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: navyBlu.withOpacity(0.9),  
      body: SingleChildScrollView(
       
        child: Container(
          height: height - 50, 
          alignment: Alignment.bottomCenter,
          constraints: BoxConstraints(
            // setting minimum height equal to 100% of VH
            minHeight: height
          ),
          // making width of outer wrapper to 100%
          width: width,
          child: Container(
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 25),
    
    
            child: Column(
              mainAxisSize: MainAxisSize.min,  //NB
              children: <Widget>[
                
                // buiding the logo display
                const SizedBox( height: 40.0),
                const LogoDisply(),
              
                Form(
                  key: signinExistingUserForm,
                  child: Column(
                    children:  <Widget>[
    
                      // building the display heading
                      const SizedBox( height: 20.0),
                      const SignInTex(),
    
    
                      // building email input box                
                      const SizedBox( height: 20.0),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,  //NB
                            children: const <Widget>[
                              Text("Email-address", style: lableText,),
                              Text("*", style: lableText,),
                                
                            ],
                          ),
                          const SizedBox( height: 5.0),
                          
                          TextFormField(
                            controller: _exUserEmail,
                            validator: (val){
                              if ( val == null || val.isEmpty ) {
                                return 'Please eneter your emailaddress';
                              } else if( !regexEmail.hasMatch(val) ){
                                return 'Please eneter a suitable emailaddress';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration:  InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: chromeYel ,width: 1.0),
                                borderRadius: BorderRadius.circular(22.5),
                              ),
                              filled: true,
                              fillColor: chromeYel,
                              prefixIcon:  const Icon( 
                                Icons.email,
                                color: navyBluVar,  //NB
                                size: 25.0,  //NB
                              ),
                            ),
                          ),
    
                        ],
                      ),
                      
    
                      // building password input
                      const SizedBox( height: 15.0),                
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start, 
                            children: const <Widget>[
                              Text("Password", style: lableText,),
                              Text("*", style: lableText,),
                            ],
                          ),
                          const SizedBox( height: 5.0),
                          
                          TextFormField(
                            controller: _exUserPassword,
                            validator: (val){
                              if ( val == null || val.isEmpty ) {
                                return 'Please eneter your password';
                              } else if( !regexPasswod.hasMatch(val) ){
                                return 'Please eneter a suitable password';
                              }
                              return null;
                            },
                            obscureText: _obscureText,
                            keyboardType: TextInputType.visiblePassword,
                            decoration:  InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: chromeYel ,width: 1.0),
                                borderRadius: BorderRadius.circular(22.5),
                              ),
                              filled: true,
                              fillColor: chromeYel,
                              hintText: "",
                              prefixIcon: const Icon( 
                                Icons.lock,
                                color: navyBlu, 
                                size: 25.0,  //NB
                              ),
                              suffixIcon: IconButton(
                                onPressed: _toggle,
                                icon: Icon(
                                  _obscureText ?  Icons.visibility : Icons.visibility_off,
                                  color: navyBlu,
                                  size: 20.0,
                                ),
                              ),
    
                            ),
                          ),
    
                        ],
                      ),
                      
    
                      //building login button
                      const SizedBox( height: 10.0),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric( vertical: 20 ),
                        child: ElevatedButton(
                          child: const Text('SignIn',
                          style: TextStyle(
                              color: chromeYel,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            // If the form is valid
                            if ( signinExistingUserForm.currentState!.validate() ) {
    
                              // initiate http post requesite 
                              signMeIn();
                              // this ensures that the textfield button is cleared after the submit-button has been pressed 
                              _exUserEmail.clear();
                              _exUserPassword.clear();
                              // show progress indicator on click
                              setState(() => isApiProcess = true );
                              
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              navyBlu
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent
                            ),
                            overlayColor: MaterialStateProperty.all<Color>(
                            Colors.transparent
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                  side: const BorderSide(
                                    color: navyBlu, 
                                    width: 3.0,
                                  ),
                              ),
                            ),
                            minimumSize:  MaterialStateProperty.all<Size>(
                              const Size( 350.0,70.0),
                            ),
                          ),
                        ),
                      ),
    
    
                      const SizedBox( height: 5.0),
                      const CreatingUserTex(),
                      
    
                    ],
                  )
                ),
    
              ],
    
            ),
          ),
    
        ),
      ),
    );
  }
}