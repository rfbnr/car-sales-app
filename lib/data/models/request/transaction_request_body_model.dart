import 'dart:convert';

class TransactionRequestBodyModel {
  final String? transactionDate;
  final String? buyerName;
  final String? buyerAddress;
  final String? buyerCode;
  final String? buyerJob;
  final String? buyerPhoneNumber;
  final String? fakturNumber;
  final String? merk;
  final String? color;
  final int? year;
  final int? price;
  final String? carName;
  final String? carCode;

  TransactionRequestBodyModel({
    this.transactionDate,
    this.buyerName,
    this.buyerAddress,
    this.buyerCode,
    this.buyerJob,
    this.buyerPhoneNumber,
    this.fakturNumber,
    this.merk,
    this.color,
    this.year,
    this.price,
    this.carName,
    this.carCode,
  });

  factory TransactionRequestBodyModel.fromRawJson(String str) =>
      TransactionRequestBodyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionRequestBodyModel.fromJson(Map<String, dynamic> json) =>
      TransactionRequestBodyModel(
        transactionDate: json["transactionDate"],
        buyerName: json["buyerName"],
        buyerAddress: json["buyerAddress"],
        buyerCode: json["buyerCode"],
        buyerJob: json["buyerJob"],
        buyerPhoneNumber: json["buyerPhoneNumber"],
        fakturNumber: json["fakturNumber"],
        merk: json["merk"],
        color: json["color"],
        year: json["year"],
        price: json["price"],
        carName: json["carName"],
        carCode: json["carCode"],
      );

  Map<String, dynamic> toJson() => {
        "transactionDate": transactionDate,
        "buyerName": buyerName,
        "buyerAddress": buyerAddress,
        "buyerCode": buyerCode,
        "buyerJob": buyerJob,
        "buyerPhoneNumber": buyerPhoneNumber,
        "fakturNumber": fakturNumber,
        "merk": merk,
        "color": color,
        "year": year,
        "price": price,
        "carName": carName,
        "carCode": carCode,
      };
}
