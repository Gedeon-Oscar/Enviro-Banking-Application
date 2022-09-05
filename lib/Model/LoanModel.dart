// converting string --> double
// var onePointOne = double.parse('1.1');
// converting string --> int [this is done through casting]
//var a = 10; // An integer.
//var b = "20"; // A string.
//var c = int. parse(b);
//print(a + c);
// http://ec2-63-33-169-221.eu-west-1.compute.amazonaws.com/loans-api/v2/api-docs



// creating the LoanApplication class that contains the posting data from the swagger document
class LoanApplication{

  final int? amount;
  final BankAccount? bankAccount;
  final String? collectionDate;
  final String? firstName;
  final int? idNumber;
  final String? lastName; 

  LoanApplication({ this.amount,this.bankAccount,this.collectionDate,this.firstName,this.idNumber,this.lastName});
  // factory constructor that creates an LoanApplication from JSON.
  factory LoanApplication.fromJson(Map<String, dynamic> json) {
    return LoanApplication(
      // converting JSON by hand
      amount: json['amount'],
      bankAccount: BankAccount.fromJson( json['bankAccount'] ),
      collectionDate: json['collectionDate'],
      firstName: json['firstName'],
      idNumber: json['idNumber'],
      lastName: json['lastName']
    );
  }

  // that creates an LoanApplication to JSON.
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'bankAccount': bankAccount,  //NB
      'collectionDate': collectionDate,
      'firstName': firstName,
      'idNumber': idNumber,
      'lastName': lastName,

    };
  }

}

// creating the LoanApplicationResponse class that contains the response data from the swagger document
class LoanApplicationResponse{

  final bool? approved;
  final String? reference;
  final String? erorrs;
  final String? warnings;

  LoanApplicationResponse({ this.approved,this.reference,this.erorrs,this.warnings });
  // factory constructor that creates an LoanApplicationResponse from JSON.
  factory LoanApplicationResponse.fromJson(Map<String, dynamic> json) {
    return LoanApplicationResponse(
      // converting JSON by hand
      approved: json['approved'],
      reference: json['reference'],
      erorrs: json['erorrs'],
      warnings: json['warnings'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'approved': approved,
      'reference': reference,  
      'erorrs': erorrs,
      'warnings': warnings,
    };
  }

}

// creating the BankAccount class that that contains the bank deatials required from the swagger document
class BankAccount{

  final int? accountNumber;
  final String? bankName;
  final int? branchCode;

  BankAccount({ this.accountNumber,this.bankName,this.branchCode });
  // factory constructor that creates an BankAccount from JSON.
  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      // converting JSON by hand
      accountNumber: json['accountNumber'],
      bankName: json['bankName'],
      branchCode: json['branchCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountNumber': accountNumber,
      'bankName': bankName,  
      'branchCode': branchCode,
    };
  }

}
