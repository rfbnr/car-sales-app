import 'dart:convert';

class LoginRequestBodyModel {
  final String? email;
  final String? password;

  LoginRequestBodyModel({
    this.email,
    this.password,
  });

  factory LoginRequestBodyModel.fromRawJson(String str) =>
      LoginRequestBodyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginRequestBodyModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestBodyModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
