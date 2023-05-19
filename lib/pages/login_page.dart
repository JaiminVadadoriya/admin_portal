import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'home_page.dart';
import '../login/Reuable_Widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: <Widget>[
                  resuableTextField("Enter Username", Icons.person_outline,
                      false, _emailTextController),
                  SizedBox(
                    height: 20,
                  ),
                  resuableTextField("Enter Password", Icons.lock_outline, true,
                      _passwordTextController),
                  SizedBox(
                    height: 20,
                  ),
                  signinsignupButton(context, true, () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      if (_emailTextController.text == "admin@gmail.com" &&
                          _passwordTextController.text == "admin123") {
                        print("sing in");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('you can not log in'),
                          ),
                        );
                      }
                    }).onError((error, stackTrace) {
                      if (error == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No user found for that email.'),
                          ),
                        );
                        // print('No user found for that email.');
                      } else if (error.toString() ==
                          '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
                        // print('Wrong password provided for that user.');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Wrong password provided for that user.'),
                          ),
                        );
                      }
                      print("Error ${error.toString()}");
                    });
                  }),
                ],
              )),
        ),
      ),
    );
  }
}
