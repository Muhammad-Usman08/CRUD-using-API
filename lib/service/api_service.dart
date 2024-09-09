import 'dart:convert';

import 'package:crud/model/api_model.dart';
import 'package:http/http.dart' as http;

//getting api response
class ApiService {
  Future getData() async {
    List<ApiModel> data = [];
    var mainUrl =
        'https://crudcrud.com/api/cc2b747e97994a2e8a14d9a5bb67840f/tasks';
    var url = Uri.parse(mainUrl);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      for (var i in jsonResponse) {
        data.add(ApiModel.fromJson(i));
      }
    } else {
      print(response.statusCode);
    }
    return data;
  }

  Future addData() async {
    var url = Uri.parse(
        'https://crudcrud.com/api/cc2b747e97994a2e8a14d9a5bb67840f/tasks');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {"title": "Muhammad Ammar", "subtitle": "He is a Sales Executive"},
      ),
    );
    print(response);
  }

  Future updataData(String id) async {
    var url = Uri.parse(
        'https://crudcrud.com/api/cc2b747e97994a2e8a14d9a5bb67840f/tasks/$id');
    var response = http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {"title": "Muhammad Ayaan", "subtitle": "He is naba ka ashiq"},
      ),
    );
  }

  deleteData(String id) async {
    var url = Uri.parse(
        'https://crudcrud.com/api/cc2b747e97994a2e8a14d9a5bb67840f/tasks/$id');
    await http.delete(url);
  }
}
