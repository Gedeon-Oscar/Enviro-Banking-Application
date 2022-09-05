import 'dart:ui';
// main(root) application import
import 'package:flutter/material.dart';
// flutter dependence(s)
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// application tools import(s)
import 'package:flutter_application_enviro_banking_application/AppTools/ConstPg.dart';
import 'package:flutter_application_enviro_banking_application/AppTools/Progressor.dart';
import 'package:flutter_application_enviro_banking_application/AppTools/Constants.dart';
// application model import(s)
import 'package:flutter_application_enviro_banking_application/Model/LoanModel.dart';


class LoanSreen extends StatefulWidget {
  const LoanSreen({Key? key, 
  this.onSubmit,this.userFirstNameOnSubmit,
  this.userLastNameOnSubmit,
  this.userIDnumOnSubmit,

  this.userAccNumOnSubmit,
  this.userBranchCodeOnSubmit,
  this.userCollDateOnSubmit,
  this.userloanAmountOnSubmit, 
  }) : super(key: key); 
  final ValueChanged<String>? onSubmit,userFirstNameOnSubmit,userLastNameOnSubmit,userIDnumOnSubmit,userAccNumOnSubmit,userBranchCodeOnSubmit,userCollDateOnSubmit,userloanAmountOnSubmit;  

  @override
  State<LoanSreen> createState() => _LoanSreenState();
}

class _LoanSreenState extends State<LoanSreen> {

  // initialing and declarating the User model form UserModel.dart
  LoanApplication loanApplication = LoanApplication();
  // initialing and declarating the User model form LoanApplication.dart
  LoanApplicationResponse loanApplicationResponse = LoanApplicationResponse();
  // initialing and declarating the global Form key
  final GlobalKey<FormState> loanApplicationForm = GlobalKey<FormState>();
  // creating a TextEditingController
  final TextEditingController _userFirstName = TextEditingController();
  final TextEditingController _userLastName = TextEditingController();
  final TextEditingController _userIDnum = TextEditingController();
  final TextEditingController _userAccNum = TextEditingController();
  final TextEditingController _userBranchCode = TextEditingController();
  final TextEditingController _userCollDate = TextEditingController();
  final TextEditingController _userloanAmount = TextEditingController();

  // dispose TextEditingControllers when the widget is unmounted  //NB why
  @override
  void dispose(){
    _userFirstName.dispose();
    _userLastName.dispose();
    _userIDnum.dispose();
    _userAccNum.dispose();
    _userBranchCode.dispose();
    _userCollDate.dispose();
    _userloanAmount.dispose();
    super.dispose();
  }

  // declarating variable that will store the dropdown content
  var bankNameDropdownVar;

  // We can also add a getter variable to control the _errorText that we pass to the TextField  //Why?llllllllllllllllllllllllllllllll
  String? get _errorText {
    // at any time, we can get the text from bankNameDropdownVar
    final text = bankNameDropdownVar;
    // applying returned warning condition
    if ( text == "VBS") {
      return '“refer to compliance”';
    }
    return null;
  }

  // I want the errors of each text-field to appear as the user inputs their wrong data within each text-field
  String? get _userFirstNameErrorText {
    final userFirstName = _userFirstName.value.text;
    if( userFirstName.isEmpty ){
      return null;
    }
    // applying returned warning conditions
    if( !regexUserName.hasMatch(userFirstName) ){
      return 'Please remove any special characters or digits';
    }
    // return null if the text is valid
    return null;
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  String? get _userLastNameErrorText {
    final userLastName = _userLastName.text;
    if( userLastName.isEmpty ){
      return null;
    }
    if( !regexUserName.hasMatch(userLastName) ){
      return 'Please remove any special characters or digits';
    }
    // return null if the text is valid
    return null;
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  String? get _userIDnumErrorText {
    final userIDnum = _userIDnum.text;
    if( userIDnum.isEmpty ){
      return null;
    }
    if( !regexIDnum.hasMatch(userIDnum) ){
      return 'Please eneter a suitable ID number';
    }
    // return null if the text is valid
    return null;
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  String? get _userAccNumErrorText {
    final userAccNum = _userAccNum.text;
    if( userAccNum.isEmpty ){
      return null;
    }
    if( !regexAccNum.hasMatch(userAccNum) ){
      return 'Please eneter a suitable account number';
    }
    // return null if the text is valid
    return null;
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  String? get _userBranchCodeErrorText {
    final userBranchCode = _userBranchCode.text;
    if( userBranchCode.isEmpty ){
      return null;
    }
    if( !regexBranchCode.hasMatch(userBranchCode) ){
      return 'Please enter numeric values';
    }
    // return null if the text is valid
    return null;
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  String? get _userCollDateErrorText {
    final userCollDate = _userCollDate.text;
    if( userCollDate.isEmpty ){
      return null;
    }
    if( !regexColdate.hasMatch(userCollDate) ){
      return 'Please eneter a data in the form of Y-M-D';
    }
    // return null if the text is valid
    return null;
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  String? get _userloanAmountErrorText {
    final userloanAmount = _userloanAmount.text;
    if( userloanAmount.isEmpty ){
      return null;
    }
    if( !regexloanAmount.hasMatch(userloanAmount) || !regexBranchCode.hasMatch(userloanAmount) ){
      return 'Please enter numeric values';
    }
    // return null if the text is valid
    return null;
  }   

  // we call a _submit method if the text is not empty.
  bool _submitted = false;
  // for this, I will call a _textFieldVaildator method when a textfield is not empty
  void _textFieldVaildator() {
     // adding a _submitted state variable that is only set to true when the submit button is pressed
    // so that errors only show any errors after the text has been submitted.
    setState(() => _submitted = true);
    // if there is no error text
    // notify the parent widget via the onSubmit callback
    if( _userFirstNameErrorText == null ){
      widget.userFirstNameOnSubmit!(_userFirstName.value.text);
    }
    if( _userLastNameErrorText == null ){
      widget.userLastNameOnSubmit!(_userLastName.value.text);
    }
    if(_userIDnumErrorText == null ){
      widget.userIDnumOnSubmit!(_userIDnum.value.text);
    }
    if(_userAccNumErrorText == null ){
      widget.userAccNumOnSubmit!(_userAccNum.value.text);
    }
    if(_userBranchCodeErrorText == null ){
      widget.userBranchCodeOnSubmit!(_userBranchCode.value.text);
    }
    if(_userCollDateErrorText == null ){
      widget.userCollDateOnSubmit!(_userCollDate.value.text);
    }
    if(_userloanAmountErrorText == null ){
      widget.userloanAmountOnSubmit!(_userloanAmount.value.text);
    }
  }

  // we call a _vbsVailator method if the bankNameDropdownVar is not empty.
  void _vbsVailator() {
    // if there is no error text
    if (_errorText == null) {
      // notify the parent widget via the onSubmit callback
      widget.onSubmit!(bankNameDropdownVar);  //NB  !  added
      // initiate http post requesite
      applyForLoan();
    }
  }

  // http post-reuesit 
  Future<void> applyForLoan() async {
    // creating the LoanApplication class instance inside of the applyForLoan method
    loanApplication = LoanApplication(  
      amount: int. parse( _userloanAmount.text ), // converting the str type to that of int
      bankAccount: BankAccount(
        accountNumber: int. parse( _userAccNum.text ),
        bankName: bankNameDropdownVar,
        branchCode: int. parse( _userBranchCode.text ),
      ),
      collectionDate: _userCollDate.text,
      firstName:  _userFirstName.text,
      idNumber: int. parse( _userIDnum.text ), 
      lastName:  _userLastName.text,
    );

    loanApplicationResponse = LoanApplicationResponse();

    var url = Uri.parse(ApiConstLoan.baseUrl + ApiConstLoan.usersEndpoint);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // loanApplication model
      body: json.encode( loanApplication.toJson() ),
    );
    if(response.Code == 200 ){
      var jsondata = json.decode(response.body);
      print( jsondata );
      // if the data is successfully posted
      //[1] display message dialog
      showAlertDialog(context);
      //[2]
      print(
        json.encode(
          LoanApplicationResponse(
            approved: true,
            reference: '',
            erorrs: '',
            warnings: '',
          ).toJson()
        )
      );
    }else{

      //[2]
      print(
        json.encode(
          LoanApplicationResponse(
            approved: false,
            reference: '',
            erorrs: '',
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

    // initialing and declarating rotation variables
    const degress = 270;  // deg by which I want my widget to rotate to
    const angle = degress * 3.141592654 / 180;  // converting that deg

    // initialing and declarating variable in the state class  
    var _userFirstNameText = '';
    var _userLastNameText = '';
    var _userIDnumText = '';
    var _userAccNumText = '';
    var _userBranchCodeText = '';
    var _userCollDateText = '';
    var _userloanAmountText = '';

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      backgroundColor: navyBluVar,
      appBar: AppBar(
        backgroundColor: navyBlu,
        shadowColor: Colors.black,
        centerTitle: true,
        title: const Text('Apply for a Loan',
          style: loanSreenTitle,
          textAlign: TextAlign.center
        ),
      ),


      body: SingleChildScrollView(

        child: Container(
          height: height + 75, 
          alignment: Alignment.bottomCenter,
          constraints: BoxConstraints(
            // setting minimum height equal to 100% of VH
            minHeight: height
          ),
          // making width of outer wrapper to 100%
          width: width,
          child: Container(
            height: height + 60,
            padding: const EdgeInsets.symmetric(horizontal: 25,),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                Form(
                  key: loanApplicationForm,
                  child: Column(
                    //mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      // building user name input box  
                      const SizedBox( height: 0.0),
                      TextFormField(
                        controller: _userFirstName,
                        // this will cause the widget to rebuild whenever the text changes
                        onChanged: (text) => setState(() => _userFirstNameText),
                        validator: (val){
                          // all textfilds are required
                          if ( val == null || val.isEmpty ) {
                            return 'Please eneter your name';
                          } 
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255,255,255,255) ,width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          // use the getter variable defined above
                          // only show the error text if the form was submitted
                          //errorText: _submitted ? _userFirstNameErrorText : null,
                          errorText: _submitted ? null  :  _userFirstNameErrorText,
                          filled: true,
                          hintText: 'First Name',
                          fillColor: Colors.white,
                          prefixIcon:  const Icon( 
                            Icons.perm_identity_rounded,
                            color: chromeYel,
                            size: 25.0, 
                          ),
                        ),
                      ),
                      const SizedBox( height: 8.0),


                      // building user last name input box
                      TextFormField(
                        controller: _userLastName,
                        // this will cause the widget to rebuild whenever the text changes
                        onChanged: (text) => setState(() => _userLastNameText),
                        validator: (val){
                          if ( val == null || val.isEmpty ) {
                            return 'Please eneter your last name';
                          } 
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255,255,255,255) ,width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          // use the getter variable defined above
                          // only show the error text if the form was submitted
                          //errorText: _submitted ? _errorText : null,
                          errorText: _submitted ? null  :  _userLastNameErrorText,
                          filled: true,
                          hintText: 'Last Name',
                          fillColor: Colors.white,
                          prefixIcon:  const Icon( 
                            Icons.perm_identity,
                            color: chromeYel,
                            size: 25.0, 
                          ),
                        ),
                      ),
                      const SizedBox( height: 8.0),


                      // building user ID number input box
                      TextFormField(
                        controller: _userIDnum,
                        // this will cause the widget to rebuild whenever the text changes
                        onChanged: (text) => setState(() => _userIDnumText),
                        validator: (val){
                          if ( val == null || val.isEmpty ) {
                            return 'Please eneter your ID number';
                          }  
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.only( top: 20 ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255,255,255,255) ,width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          errorText: _submitted ? null  :  _userIDnumErrorText,
                          filled: true,
                          hintText: 'ID number',
                          fillColor: Colors.white,
                          prefixIcon:  const Icon( 
                            Icons.card_membership, 
                            color: chromeYel,  
                            size: 25.0, 
                          ),
                          /*prefixIcon:  const FaIcon(   
                            FontAwesomeIcons.idCard, 
                            color: chromeYel,  
                            size: 26,  
                          ),*/
                        ),
                      ),
                      const SizedBox( height: 8.0),


                      // building user bank name downDrop
                      bankNameDropdown(),
                      const SizedBox( height: 8.0),


                      // building user account number input box
                      TextFormField(
                        controller: _userAccNum,
                        onChanged: (text) => setState(() => _userAccNumText),
                        validator: (val){
                          if ( val == null || val.isEmpty ) {
                            return 'Please eneter your Account number';
                          } 
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.only( bottom: 16.0 ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255,255,255,255) ,width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          errorText: _submitted ? null  :  _userAccNumErrorText,
                          filled: true,
                          hintText: 'Account number',
                          fillColor: Colors.white,
                          prefixIcon:  const FaIcon( 
                            FontAwesomeIcons.asterisk, 
                            color: Colors.transparent,
                            size: 18,  
                          ),
                        ),
                      ),
                      const SizedBox( height: 8.0),


                      // building user branchCode input box
                      TextFormField(
                        controller: _userBranchCode,
                        onChanged: (text) => setState(() => _userBranchCodeText),
                        validator: (val){
                          if ( val == null || val.isEmpty ) {
                            return 'Please eneter your Branch Code';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.only( bottom: 16.0 ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255,255,255,255) ,width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          errorText: _submitted ? null  :  _userBranchCodeErrorText,
                          filled: true,
                          hintText: 'Branch Code',
                          fillColor: Colors.white,
                          prefixIcon:  const FaIcon( 
                            FontAwesomeIcons.asterisk, 
                            color: Colors.transparent,  
                            size: 18,  
                          ),
                        ),
                      ),
                      const SizedBox( height: 8.0),


                      // building user collection date input box
                      TextFormField(
                        controller: _userCollDate,
                        onChanged: (text) => setState(() => _userCollDateText),
                        validator: (val){
                          if ( val == null || val.isEmpty ) {
                            return 'Please eneter your collection date';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.datetime,
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255,255,255,255) ,width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          errorText: _submitted ? null  :  _userCollDateErrorText,
                          filled: true,
                          hintText: 'Collection date',
                          fillColor: Colors.white,
                          prefixIcon:  const Icon( 
                            Icons.date_range,
                            color: chromeYel,
                            size: 25.0,  
                          ),
                        ),
                      ),
                      const SizedBox( height: 8.0),


                      // building user loan amount input box
                      TextFormField(
                        controller: _userloanAmount,
                        onChanged: (text) => setState(() => _userloanAmountText),
                        validator: (val){
                          if ( val == null || val.isEmpty ) {
                            return 'Please eneter your loan amount';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255,255,255,255) ,width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          errorText: _submitted ? null  :  _userloanAmountErrorText,
                          filled: true,
                          hintText: 'Loan amount',
                          fillColor: Colors.white,
                          prefixIcon:  const Icon( 
                            Icons.attach_money,  
                            color: chromeYel,  
                            size: 25.0,  
                          ),
                        ),
                      ),
                      const SizedBox( height: 8.0),
                       
                   

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),

      ),


      floatingActionButton: Transform.rotate(
        angle: angle,
        child: Padding(
          padding: const EdgeInsets.only( bottom: 20 ),
          child: FloatingActionButton(
            onPressed: (){
              if ( loanApplicationForm.currentState!.validate() ) {
                // if the bankNameDropdownVar variable has string equal to "VBS" then the _vbsVailaton fuction is called
                bankNameDropdownVar == "VBS" ?  _vbsVailator() : Container();
                // xxxxxx
                setState(() => _textFieldVaildator() );
                // show progress indicator on click
                setState(() => isApiProcess = true );
              }
            },
            tooltip: 'Apply now',
            backgroundColor: const Color.fromARGB(100, 255, 255, 255),
            hoverColor: Colors.white,
            child: const Icon(
              Icons.send,
              color: chromeYel,
              size: 27.5,
            ),
          ),
        ),
      ),


    );
  }



  Widget bankNameDropdown() {
    return Center(
        child:Padding(
          padding: const EdgeInsets.all(1.0),

          child: Container(
            padding: const EdgeInsets.only( right: 4.0, left: 4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    errorText: _errorText,
                    errorMaxLines: 1,
                    errorStyle: const TextStyle(
                      height: 3,
                    ),
                    prefixIcon: const Icon( Icons.account_balance, size: 25, color: chromeYel,), 
                  ),
                                    
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: const Text("Bank name",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          fontSize: 15.0,
                        ),
                      ),
                      enableFeedback: true,
                      borderRadius: BorderRadius.circular(20),
                      dropdownColor: Colors.white,
                      focusColor: navyBluLight,
                      icon: const Icon(Icons.arrow_drop_down_circle, color: chromeYel, ),
                      iconSize: 30.0,
                      value: bankNameDropdownVar,
                      isDense: true,
                      isExpanded: true,
                      underline: const SizedBox(),
                      style: btnInnerTex,
                      onChanged: (newValue) {
                        setState(() {
                          bankNameDropdownVar = newValue;
                        });
                        print(bankNameDropdownVar);
                      },
                      items: bankNameDropdownValues.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),

        ),
    );  
  }

  // success response
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      // after the user has received their success response, all the textfield inputs become cleared
      onPressed: () { 
      _userFirstName.clear();
      _userLastName.clear();
      _userIDnum.clear();
      _userAccNum.clear();
      _userBranchCode.clear();
      _userCollDate.clear();
      _userloanAmount.clear();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Enviro Banking"),
      content: Text("Congratulations {$_userFirstName} {$_userLastName}! Your loan for {$_userloanAmount} has been approved."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  } 

}
