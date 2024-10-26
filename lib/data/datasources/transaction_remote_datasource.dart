import 'package:dartz/dartz.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../core/constants/variables.dart';
import '../models/request/transaction_request_body_model.dart';
import '../models/response/error_response_model.dart';
import '../models/response/success_response_model.dart';
import '../models/response/transaction_response_model.dart';
import 'auth_local_datasource.dart';

class TransactionRemoteDatasource {
  HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  Future<Either<ErrorResponseModel, TransactionResponseModel>>
      getTransactionByUser() async {
    final authData = await AuthLocalDatasource().getAuthData();

    final Map<String, String> headers = {
      "User-ID": authData.data?.id ?? "User-ID not found",
    };

    final response = await http.get(
      Uri.parse("${Variables.baseUrl}/transactions"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Right(TransactionResponseModel.fromRawJson(response.body));
    } else {
      return Left(ErrorResponseModel.fromRawJson(response.body));
    }
  }

  Future<Either<ErrorResponseModel, SuccessResponseModel>>
      transactionRequestForm({
    required TransactionRequestBodyModel transactionRequestModel,
  }) async {
    final authData = await AuthLocalDatasource().getAuthData();

    final Map<String, String> headers = {
      "User-ID": " ${authData.data?.id ?? "User-ID not found"}",
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final response = await http.post(
      Uri.parse("${Variables.baseUrl}/transactions"),
      headers: headers,
      body: transactionRequestModel.toRawJson(),
    );

    if (response.statusCode == 201) {
      return Right(SuccessResponseModel.fromRawJson(response.body));
    } else {
      return Left(ErrorResponseModel.fromRawJson(response.body));
    }
  }
}
