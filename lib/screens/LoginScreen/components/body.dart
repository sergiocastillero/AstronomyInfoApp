import '../../LoginScreen/components/login_box.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// It provide us total height and weidth
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/imatge/backgroundLogin.jpg"),
        fit: BoxFit.cover,
      )),
      child: Column(
        children: [
          Container(
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Image(
                  image: AssetImage("assets/imatge/logo.png"),
                  width: 150,
                  height: 150,
                ),
              ),
            ),
          ),
          loginBox(),
        ],
      ),
    );
  }
}
