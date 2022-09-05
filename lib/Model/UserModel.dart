


// creating the User class that contains the data from the swagger document
class User{

  final String? emailAddress;
  final String? password;

  User({ this.emailAddress,this.password });
  // factory constructor that creates an SignInUser from JSON.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // converting JSON by hand
      emailAddress: json['emailAddress'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailAddress': emailAddress,
      'password': password,
    };
  }

}


