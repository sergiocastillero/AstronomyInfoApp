import '../..//NavBarScreen/bottomMenu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class loginBox extends StatelessWidget {
  String emailValue = "";
  String passValue = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Email is requird";
                          }
                        },
                        onSaved: (value) {
                          emailValue = value.toString();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Password is requird";
                          }
                        },
                        onSaved: (value) {
                          passValue = value.toString();
                        },
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        child: const Text(
                          "LOGIN NOW",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            ValidLogin(emailValue, passValue, context);
                          }
                        },
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

void ValidLogin(String email, String password, BuildContext context) async {
  var valid = await apiService.login(email, password);
  if (valid) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => bottomNav()));
  } else {
    print("login failed");
  }
}
