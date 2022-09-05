// VaildationResponse


// creating the VaildationResponse class that contains the data from the swagger document
class VaildationResponse{

  final String? errors;
  final bool? success;
  final String? warnings;

  VaildationResponse({ this.errors,this.success,this.warnings });
  // factory constructor that creates an SignInUser from JSON.
  factory VaildationResponse.fromJson(Map<String, dynamic> json) {
    return VaildationResponse(
      // converting JSON by hand
      errors: json['errors'],
      success: json['success'],
      warnings: json['warnings']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'errors': errors,
      'success': success,
      'warnings': warnings,
    };
  }

}