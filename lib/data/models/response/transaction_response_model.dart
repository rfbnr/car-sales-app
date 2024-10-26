import 'dart:convert';

class TransactionResponseModel {
  final int? status;
  final String? code;
  final String? message;
  final List<TransactionResultResponseModel>? data;

  TransactionResponseModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory TransactionResponseModel.fromRawJson(String str) =>
      TransactionResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionResponseModel.fromJson(Map<String, dynamic> json) =>
      TransactionResponseModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TransactionResultResponseModel>.from(json["data"]!
                .map((x) => TransactionResultResponseModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TransactionResultResponseModel {
  final String? id;
  final String? fakturNumber;
  final String? code;
  final String? createdBy;
  final int? amount;
  final dynamic transactionDate;
  final Car? car;
  final Buyer? buyer;

  TransactionResultResponseModel({
    this.id,
    this.fakturNumber,
    this.code,
    this.createdBy,
    this.amount,
    this.transactionDate,
    this.car,
    this.buyer,
  });

  factory TransactionResultResponseModel.fromRawJson(String str) =>
      TransactionResultResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionResultResponseModel.fromJson(Map<String, dynamic> json) =>
      TransactionResultResponseModel(
        id: json["id"],
        fakturNumber: json["fakturNumber"],
        code: json["code"],
        createdBy: json["createdBy"],
        amount: json["amount"],
        transactionDate: json["transactionDate"],
        car: json["car"] == null ? null : Car.fromJson(json["car"]),
        buyer: json["buyer"] == null ? null : Buyer.fromJson(json["buyer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fakturNumber": fakturNumber,
        "code": code,
        "createdBy": createdBy,
        "amount": amount,
        "transactionDate": transactionDate,
        "car": car?.toJson(),
        "buyer": buyer?.toJson(),
      };
}

class Buyer {
  final String? id;
  final String? name;
  final String? address;
  final String? code;
  final String? job;
  final String? phoneNumber;

  Buyer({
    this.id,
    this.name,
    this.address,
    this.code,
    this.job,
    this.phoneNumber,
  });

  factory Buyer.fromRawJson(String str) => Buyer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        code: json["code"],
        job: json["job"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "code": code,
        "job": job,
        "phoneNumber": phoneNumber,
      };
}

class Car {
  final String? id;
  final String? name;
  final String? color;
  final String? code;
  final String? merk;
  final int? year;
  final int? price;

  Car({
    this.id,
    this.name,
    this.color,
    this.code,
    this.merk,
    this.year,
    this.price,
  });

  factory Car.fromRawJson(String str) => Car.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        name: json["name"],
        color: json["color"],
        code: json["code"],
        merk: json["merk"],
        year: json["year"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
        "code": code,
        "merk": merk,
        "year": year,
        "price": price,
      };
}
