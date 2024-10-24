import 'dart:convert';

class RegisterRequestBodyModel {
  final String? name;
  final String? email;
  final String? password;

  RegisterRequestBodyModel({
    this.name,
    this.email,
    this.password,
  });

  factory RegisterRequestBodyModel.fromRawJson(String str) =>
      RegisterRequestBodyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterRequestBodyModel.fromJson(Map<String, dynamic> json) =>
      RegisterRequestBodyModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
      };
}
