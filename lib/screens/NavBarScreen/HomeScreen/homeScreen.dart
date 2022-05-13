// import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterapi/ApiService/ApiService.dart';
import 'package:flutterapi/ApiService/Apod.dart';
import 'package:flutterapi/screens/NavBarScreen/HomeScreen/components/body.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ApiService apiService = ApiService();

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<Apod>(
        future: apiService.getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.white, strokeWidth: 4));
            case ConnectionState.done:
              if (snapshot.hasData) {
                return Body(snapshot: snapshot);
              } else {
                return Text('${snapshot.error}');
              }
          }
        },
      ),
    );
  }
}
