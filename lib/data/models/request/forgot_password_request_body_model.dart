import 'dart:convert';

class ForgotPasswordRequestBodyModel {
  final String? email;
  final String? newPassword;

  ForgotPasswordRequestBodyModel({
    this.email,
    this.newPassword,
  });

  factory ForgotPasswordRequestBodyModel.fromRawJson(String str) =>
      ForgotPasswordRequestBodyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForgotPasswordRequestBodyModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordRequestBodyModel(
        email: json["email"],
        newPassword: json["newPassword"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "newPassword": newPassword,
      };
}
