import 'package:flutter/material.dart';


/*
  Application text-styling
*/
const largeText = TextStyle(
  fontSize: 22.5,
  fontWeight: FontWeight.bold,
  color: chromeYel,
);
const lableText = TextStyle(
  fontWeight: FontWeight.bold,
  color: chromeYel,
);
const btnInnerTex = TextStyle(
  color: Colors.black,
  fontSize: 16.0,
  fontWeight: FontWeight.w700,
);
const loanSreenTitle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 25.0,
  color: Colors.white,
);


/*
  Bank name associated with Account numbe
*/
const bankNameDropdownValues = ["ABSA","Capitec","FNB","Investec Limited","Nedbank Limited","Standard Bank","VBS"];


/*
  Application colors
*/
const navyBluLight = Color.fromARGB(96, 0, 0, 128);
const navyBlu = Color(0xff000080);
const navyBluVar = Color(0xff000090);

const brightYel = Color(0xffFFAA1D);
const chromeYel = Color(0xffFFA700);


/*
  The regular expression pattern for the different textfields.

  r'^
  (?=.*[A-Z])       // should contain at least one upper case
  (?=.*[a-z])       // should contain at least one lower case
  (?=.*?[0-9])      // should contain at least one digit
  (?=.*?[!@#\$&*~]) // should contain at least one Special character
  .{8,}             // Must be at least 8 characters in length  
  $

*/

// SignUp
RegExp regexEmail = RegExp(r'^(?=.*?[a-z])(?=.*?[!@#\$&*~]).{10,}$');
RegExp regexPasswod = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
// LoanSreen
RegExp regexUserName = RegExp('[a-zA-Z]');
RegExp regexIDnum = RegExp(r'^[0-9].{13,}');
RegExp regexAccNum = RegExp(r'^[0-9].{10,}');
RegExp regexColdate = RegExp(r'^\d{1,4}(?:-\d{1,2})(?:-\d{1,2})$');
RegExp regexBranchCode = RegExp(r'^[0-9]');
RegExp regexloanAmount = RegExp(r'(^\d*\.?\d*)');  // only allwing doubles


/*

// I am using Flutter and dart and I want RegExp to validate strings in the 024648-4568 like format, 
//where a user can only put six numbers at the start, then a - and then 4 digits at the end.
- start of string
\d{1,6} - one to six digits
(?:-\d{0,4})? - an optional sequence of
- - a hyphen
\d{0,4} - zero to four digits
$ - end of string.

*/

/*

TextFormField(
  ...
  keyboardType: TextInputType.numberWithOptions(decimal: true),
);

*/

/*

keyboardType: TextInputType.numberWithOptions(decimal: allowDecimal),
inputFormatters: <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
  TextInputFormatter.withFunction(
    (oldValue, newValue) => newValue.copyWith(
      text: newValue.text.replaceAll('.', ','),
    ),
  ),
],


TextInputFormatters can be chained. This means that within the list if input formatters the order matters. The output of the first formatter is taken as the input for the second and so on.

In our case, we want the first formatter to only allow a pattern with at least one digit [0-9]+ followed by either a dot, a comma or nothing [,.]{0,1} followed by at least zero digits [0-9]*.

Now we know that the output of this formatter is always of the mentioned format. Then we define a second formatter that replaces every occurrence of . by ,. This way, we have a normalized input, which we could easily make further use of. It doesn’t matter if the user enters a . or a , – it will always be transformed to a ..

*/