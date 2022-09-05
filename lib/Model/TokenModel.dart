


// creating the Token class that contains the data from the swagger document
class Token{

  final String? jwt;

  Token({ this.jwt });
  // factory constructor that creates an SignInUser from JSON.
  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      // converting JSON by hand
      jwt: json['jwt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jwt': jwt,
    };
  }

}