import 'dart:convert';

class SuccessResponseModel {
  final int? status;
  final String? code;
  final String? message;

  SuccessResponseModel({
    this.status,
    this.code,
    this.message,
  });

  factory SuccessResponseModel.fromRawJson(String str) =>
      SuccessResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SuccessResponseModel.fromJson(Map<String, dynamic> json) =>
      SuccessResponseModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}
