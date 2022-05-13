// import 'dart:html';

import 'dart:io';
import 'package:flutterapi/screens/DetailsScreen/components/body.dart';

import '../../ApiService/Apod.dart';
import '../../ApiService/ApodList.dart';
import 'package:flutter/material.dart';
import '../../ApiService/ApiService.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

final ApiService apiService = ApiService();

class DetailsScreen extends StatelessWidget {
  ApodList data;
  DetailsScreen({Key? key, required this.data}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fetch Data Example",
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
                return Body(data: data);
              } else {
                return Text('${snapshot.error}');
              }
          }
        },
      ),
    );
  }
}
