import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GroupService {
  var baseUrl = dotenv.get("API_URL");
  Dio get dio => Dio();

  saveGroup(jsonObj) async {
    var url = baseUrl + "/groups/add-group";
    // var encode = jsonEncode(jsonObj);
    var response = await dio.post(url, data: jsonObj);
    return response.data;
  }

  getAllGroups(id) async {
    var url = baseUrl + "/groups/get-groups-by-userid/"+id;
    // var encode = jsonEncode(jsonObj);
    var response = await dio.post(url);
    return response.data;
  }

  getPrimaryGroup(userId) async {
    var url = baseUrl + "/groups/get-primary-group/${userId}";
    // var encode = jsonEncode(jsonObj);
    var response = await dio.post(url);
    return response.data;
  }
  
  setAsPrimary(groupId, userId) async {
    var url = baseUrl + "/groups/set-as-primary/${groupId}/${userId}";
    // var encode = jsonEncode(jsonObj);
    var response = await dio.post(url);
    return response.data;
  }
}
