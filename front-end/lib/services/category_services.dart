import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryService {
  CategoryService();

  var baseUrl = dotenv.get("API_URL");

  Dio get dio => Dio();

  getCategories() {
    // var url = baseUrl+""
  }

  addCategory(jsonObj) async {
    var url = baseUrl + "/category/insert";
    var encode = jsonEncode(jsonObj);
    var response = await dio.post(url, data: encode);
    return response.data;
  }
}
