import 'package:shared_preferences/shared_preferences.dart';

import '../models/response/login_response_model.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(LoginResponseModel loginResponseModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("auth_data", loginResponseModel.toRawJson());
  }

  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("auth_data");
  }

  Future<LoginResponseModel> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString("auth_data");

    return LoginResponseModel.fromRawJson(authData!);
  }

  Future<bool> isAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString("auth_data");

    return authData != null;
  }
}
