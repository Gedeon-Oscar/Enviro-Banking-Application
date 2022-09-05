// main(root) application import
import 'package:flutter/material.dart';
// flutter dependence(s)
import 'package:http/http.dart' as http;
import 'dart:convert';
// application srceen import(s)
import 'package:flutter_application_enviro_banking_application/Srceens/SignIn.dart';
// application custom ui import(s)
import 'package:flutter_application_enviro_banking_application/CustomUI/SignupTexCard.dart';
import 'package:flutter_application_enviro_banking_application/CustomUI/ExistingUserTex.dart';
import 'package:flutter_application_enviro_banking_application/CustomUI/logoDisplyCard.dart';
// application tools import(s)
import 'package:flutter_application_enviro_banking_application/AppTools/ConstPg.dart';
import 'package:flutter_application_enviro_banking_application/AppTools/Constants.dart';
import 'package:flutter_application_enviro_banking_application/AppTools/Progressor.dart';
// application model import(s)
import 'package:flutter_application_enviro_banking_application/Model/UserModel.dart';
import 'package:flutter_application_enviro_banking_application/Model/VaildationResponseModel.dart';



class SignUp extends StatefulWidget {
  const SignUp({Key? key, this.onSubmit }) : super(key: key);
  final ValueChanged<String>? onSubmit;  //NB  ?   added

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  // http post-reuesit
  Future<void> signMeUP() async {
    // creating the User class instance inside of the signMeIn method
    user = User( emailAddress: _userEmail.text, password: _userPassword.text );
    vaildationResponse = VaildationResponse();

    var url = Uri.parse(ApiConstSignup.baseUrl + ApiConstSignup.usersEndpoint);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // the User model
      body: json.encode( user.toJson() ),
    );
    if(response.Code == 200 ){   
      var jsondata = json.decode(response.body);
      //print( jsondata );

      //[1] navigate user to the loan service srceen
      Navigator.push(context, MaterialPageRoute( builder: (context) => SignIn() ));

      //[2] VaildationResponse
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

  // initialing and declarating the User model form UserModel.dart
  User user = User();
  // initialing and declarating the User model form VaildationResponse.dart
  VaildationResponse vaildationResponse = VaildationResponse();
  // initialing and declarating the global Form key
  final GlobalKey<FormState> signupNewUserForm = GlobalKey<FormState>();
  // creating a TextEditingController
  final TextEditingController _userEmail = TextEditingController();
  // creating a TextEditingController
  final TextEditingController _userPassword = TextEditingController();

  // initialing and declarating password to be obscure
  bool _obscureText = true;
  // toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // We can also add a getter variable to control the _errorText that we pass to the TextField  //Why?
  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _userPassword.value.text;
    if ( text.isEmpty ) {
      //return 'Please eneter your password';
      // to ensure proper ux display
      return null;
    }
    if ( !regexPasswod.hasMatch(text) ) {
      return 'Password must be at least 8 characters long, with one uppercase letter, one digit and one special character';
    }
    // return null if the text is valid
    return null;
  }

  // we call a _submit method if the text is not empty.
  bool _submitted = false;
  void _submit() {
    // adding a _submitted state variable that is only set to true when the submit button is pressed
    // so that errors only show any errors after the text has been submitted.
    setState(() => _submitted = true);
    // if there is no error text
    if ( _errorText == null ) {
      // notify the parent widget via the onSubmit callback
      widget.onSubmit!(_userPassword.value.text);  //NB  !  added
    }
  }

  // dispose TextEditingController when the widget is unmounted
  @override
  void dispose(){
    _userPassword.dispose();
    super.dispose();
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

    // initialing and declarating variable in the state class  //*NB Why?
    var _text = '';

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
                const SizedBox( height: 50.0),
                const LogoDisply(),
              
                Form(
                  key: signupNewUserForm,
                  child: Column(
                    children:  <Widget>[


                      // building the display heading
                      const SizedBox( height: 20.0),
                      const SignupTex(),


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
                            // use this to control the text field
                            controller: _userEmail,
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
                              /*focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 0.5),
                                borderRadius: BorderRadius.circular(10.0),
                              ),*/
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: chromeYel ,width: 1.0),
                                borderRadius: BorderRadius.circular(20.0),
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
                            mainAxisAlignment: MainAxisAlignment.start,  //NB
                            children: const <Widget>[
                              Text("Password", style: lableText,),
                              Text("*", style: lableText,), 
                                
                            ],
                          ),
                          const SizedBox( height: 5.0),
                          
                          TextFormField(
                            // use this to control the text field
                            controller: _userPassword,
                            // this will cause the widget to rebuild whenever the text changes
                            onChanged: (text) => setState(() => _text),
                            obscureText: _obscureText,
                            keyboardType: TextInputType.visiblePassword,
                            decoration:  InputDecoration(
                              // use the getter variable defined above
                              // only show the error text if the form was submitted
                              //errorText: _submitted ? _errorText : null,
                              errorText: _submitted ? null  :  _errorText,
                              errorMaxLines: 2,
                              errorStyle: const TextStyle( color: Color.fromARGB(255, 255, 0, 0), fontWeight:FontWeight.bold, fontSize: 10, ),
                              contentPadding: const EdgeInsets.only(left: 10),
                              /*focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 0.5),
                                borderRadius: BorderRadius.circular(10.0),
                              ),*/
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(88, 0, 0, 0) ,width: 1.0),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              filled: true,
                              fillColor: chromeYel,
                              hintText: "",
                              prefixIcon: const Icon( 
                                Icons.lock,
                                color: navyBlu,  
                                size: 25.0,  
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
                      

                      // building login button
                      const SizedBox( height: 25.0),
                      ElevatedButton(
                        child: const Text('SignUP',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //only enable the button if the text is not empty
                          onPressed: !regexPasswod.hasMatch(_userPassword.value.text) ? null : (){
                            if( signupNewUserForm.currentState!.validate() ){
                              setState(() => _submit );
                              // show progress indicator on click
                              setState(() => isApiProcess = true );
                              // initiate http post requesite
                              signMeUP();
                            }
                            // this ensures that the textfield button is cleared after the submit-button has been pressed 
                            _userEmail.clear();
                            _userPassword.clear();
                          }, 
                          style: ButtonStyle(
                            minimumSize:  MaterialStateProperty.all<Size>(
                              const Size( 350.0,70.0),
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                  side: const BorderSide(
                                    color: Colors.transparent, 
                                    width: 3.0,
                                  ),
                            ),
                          ),
                        ),
                      ),

                      
                      const SizedBox( height: 5.0),
                      const ExistingUserTex(),

                      const SizedBox( height: 5.0),
                      

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