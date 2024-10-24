import 'dart:convert';

class LoginResponseModel {
  final int? status;
  final String? code;
  final String? message;
  final LoginResultResponseModel? data;

  LoginResponseModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory LoginResponseModel.fromRawJson(String str) =>
      LoginResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : LoginResultResponseModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class LoginResultResponseModel {
  final String? id;
  final String? name;
  final String? email;

  LoginResultResponseModel({
    this.id,
    this.name,
    this.email,
  });

  factory LoginResultResponseModel.fromRawJson(String str) =>
      LoginResultResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResultResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResultResponseModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
