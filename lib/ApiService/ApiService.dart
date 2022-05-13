import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Apod.dart';
import 'ApodList.dart';

class ApiService {
  Future<Apod> getData() async {
    var url = 'api.nasa.gov';
    var urlExtension = '/planetary/apod';
    final Map<String, String> queryParameters = <String, String>{
      'api_key': '6u8YizBXHawwVvOgDaJXNXJoUoxQ2xTZzxXWC11Y',
    };
    final api = Uri.https(url, urlExtension, queryParameters);
    print(api);

    final response = await http.get(api);

    if (response.statusCode == 200) {
      return Apod.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<ApodList>> getListData() async {
    var url = 'api.nasa.gov';
    var urlExtension = '/planetary/apod';
    final Map<String, String> queryParameters = <String, String>{
      'api_key': '6u8YizBXHawwVvOgDaJXNXJoUoxQ2xTZzxXWC11Y',
      'count': '10'
    };
    final api = Uri.https(url, urlExtension, queryParameters);
    print(api);

    final response = await http.get(api);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<ApodList>((json) => ApodList.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<bool> login(String user, String password) async {
    var url = "https://www.sundarabcn.com/flutter/login.php";
    bool isLogin = false;
    final prefs = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(url),
        headers: {'Accept': 'application/json'},
        body: {'username': user, 'password': password});

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["error"]) {
        showToast(jsondata["message"]);
        isLogin = false;
      } else if (jsondata["success"]) {
        showToast(jsondata["message"]);
        await prefs.setBool('login', true);
        print(jsondata["id"]);
        await prefs.setInt('id', jsondata["id"]);
        isLogin = true;
      }
    } else {
      showToast("Connection Failed");
      isLogin = false;
    }
    return isLogin;
  }

  Future<bool> addFav(String date, String explanation, String title, String url,
      String copyright) async {
    bool login = true;
    final prefs = await SharedPreferences.getInstance();
    int? id = await prefs.getInt('id');
    String idUser = "";
    if (id != null) {
      idUser = id.toString();
    }
    var url = "http://www.sundarabcn.com/flutter/addData.php";

    var response = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json'
    }, body: {
      'idUser': idUser,
      'date': date,
      'explanation': explanation,
      'title': title,
      'url': url,
      'copyright': copyright,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      print(jsondata);
      if (jsondata["error"] == 1) {
        showToast(jsondata["message"]);
        login = false;
      } else if (jsondata["success"] == 1) {
        showToast(jsondata["message"]);

        login = true;
      }
    } else {
      showToast("Connection failed");
      login = false;
    }

    return login;
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
