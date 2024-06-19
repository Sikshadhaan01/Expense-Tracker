import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class UserService {
  var baseUrl = dotenv.get("API_URL");
  Dio dio = Dio();

  signup(jsonObj) async {
    var url = baseUrl + "/users/sign-up";
    var encode = jsonEncode(jsonObj);
    var response = await dio.post(url, data: encode);
    return response.data;
  }

  login(jsonObj) async {
    var url = baseUrl + "/users/login-user";
    var encode = jsonEncode(jsonObj);
    var response = await dio.post(url, data: encode);
    return response.data;
  }

  Future getAllUsers(userId) async {
    var url = baseUrl + "/users/get-all-users/$userId";
    // var encode = jsonEncode(jsonObj);
    var response = await dio.post(url);
    return response.data;
  }
}
