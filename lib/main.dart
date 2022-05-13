import 'dart:convert';
import 'package:http/http.dart' as http;

import 'screens/NavBarScreen/bottomMenu.dart';
import 'screens/LoginScreen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ApiService/ApiService.dart';

final ApiService apiService = ApiService();
void main() async {
  final prefshared = await SharedPreferences.getInstance();
  final bool? login = prefshared.getBool('login');
  print(login);
  runApp(MaterialApp(
      title: 'Nasa',
      home: ((login != null && login == true) ? bottomNav() : const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nasa',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      //home: const LoginScreen(title: 'Nasa'),
      home: const LoginScreen(title: 'Nasa'),
    );
  }
}
