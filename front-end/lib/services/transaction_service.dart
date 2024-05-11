import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TransactionService {
  var baseUrl = dotenv.get("API_URL");

  Dio get dio => Dio();

  saveTransaction(jsonObj) async {
    var url = baseUrl + "/transaction/insert-trans";
    // var encode = jsonEncode(jsonObj);
    var response = await dio.post(url, data: jsonObj);
    return response.data;
  }

   getUserTransactions(jsonObj) async {
    var url = baseUrl + "/transaction/get-user-transactions";
    // var encode = jsonEncode(jsonObj);
    var response = await dio.post(url, data: jsonObj);
    return response.data;
  }
}
