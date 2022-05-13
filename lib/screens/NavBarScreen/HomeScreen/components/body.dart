import 'dart:io';

import 'package:flutterapi/ApiService/Apod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../homeScreen.dart';

class Body extends StatefulWidget {
  final AsyncSnapshot<Apod> snapshot;
  Body({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<Body> createState() => _MyBodyState();
}

Future<String?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  final String? id = prefs.getString('id');
  return id;
}

class _MyBodyState extends State<Body> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<String?> idUser = getUserId();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
                iconSize: 40,
                color: Colors.white,
                onPressed: () => {
                      apiService.addFav(
                          widget.snapshot.data!.date,
                          widget.snapshot.data!.explanation,
                          widget.snapshot.data!.title,
                          widget.snapshot.data!.url,
                          widget.snapshot.data!.copyright)
                    },
                icon: Icon(Icons.favorite_outline))
          ]),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: size.height * 0.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(widget.snapshot.data!.url),
                fit: BoxFit.cover,
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Container(
                width: double.infinity,
                height: size.height * 0.75,
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.snapshot.data!.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          widget.snapshot.data!.copyright,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Text(widget.snapshot.data!.date,
                          style: const TextStyle(
                            fontSize: 16,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(widget.snapshot.data!.explanation,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 16,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
