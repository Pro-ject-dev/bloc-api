import 'dart:convert';

import 'package:task_blocapi/data/model/datamodel.dart';
import 'package:http/http.dart' as http;

class DataRepos {
  static Future<List<DataModel>> fetchData() async {
    List<DataModel> result = [];
    var client = http.Client();

    try {
      var response = await client
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

      List output = jsonDecode(response.body);
      for (var i = 0; i < output.length; i++) {
        DataModel data = DataModel.fromJson(output[i]);
        result.add(data);
      }
    } catch (e) {
      print(e.toString());
    }

    return result;
  }

  static Future<bool> AddData() async {
    var client = http.Client();

    try {
      var response = await client
          .post(Uri.parse("https://jsonplaceholder.typicode.com/posts"), body: {
        "userId": "23",
        "body": "This is my bloc Task",
        "title": "Task 1"
      });
      print(response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
