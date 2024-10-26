import 'package:dartz/dartz.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../../core/constants/variables.dart';
import '../models/request/forgot_password_request_body_model.dart';
import '../models/request/login_request_body_model.dart';
import '../models/request/register_request_body_model.dart';
import '../models/response/error_response_model.dart';
import '../models/response/login_response_model.dart';
import '../models/response/register_response_model.dart';
import '../models/response/success_response_model.dart';
import 'auth_local_datasource.dart';

class AuthRemoteDatasource {
  HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  Future<Either<ErrorResponseModel, LoginResponseModel>> login({
    required String email,
    required String password,
  }) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    final LoginRequestBodyModel bodyRequestLogin = LoginRequestBodyModel(
      email: email,
      password: password,
    );

    final response = await http.post(
      Uri.parse("${Variables.baseUrl}/auth/login"),
      headers: headers,
      body: bodyRequestLogin.toRawJson(),
    );

    if (response.statusCode == 200) {
      return Right(LoginResponseModel.fromRawJson(response.body));
    } else {
      return Left(ErrorResponseModel.fromRawJson(response.body));
    }
  }

  Future<Either<ErrorResponseModel, RegisterResponseModel>> register({
    required RegisterRequestBodyModel bodyRequestRegister,
  }) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    final response = await http.post(
      Uri.parse("${Variables.baseUrl}/auth/register"),
      headers: headers,
      body: bodyRequestRegister.toRawJson(),
    );

    if (response.statusCode == 201) {
      return Right(RegisterResponseModel.fromRawJson(response.body));
    } else {
      return Left(ErrorResponseModel.fromRawJson(response.body));
    }
  }

  Future<Either<ErrorResponseModel, SuccessResponseModel>> forgotPassword({
    required ForgotPasswordRequestBodyModel body,
  }) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    final response = await http.patch(
      Uri.parse("${Variables.baseUrl}/profile/forgot-password"),
      headers: headers,
      body: body.toRawJson(),
    );

    if (response.statusCode == 200) {
      return Right(SuccessResponseModel.fromRawJson(response.body));
    } else {
      return Left(ErrorResponseModel.fromRawJson(response.body));
    }
  }

  Future<void> logout() async {
    await AuthLocalDatasource().removeAuthData();
  }
}
