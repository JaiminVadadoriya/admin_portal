import 'package:admin_portal/utils/routes.dart';
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
                  Image.asset(
                    'assets/images/login.png',
                    width: 300,
                    // height: double.infinity,
                    // width: double.infinity * .5,
                  ),
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
                    if (_emailTextController.text != "admin@gmail.com") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Wrong username provided.'),
                        ),
                      );
                      //     .onError((error, stackTrace) {
                      //   if (error == 'user-not-found') {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //         content: Text('No user found for that email.'),
                      //       ),
                      //     );
                      //     // print('No user found for that email.');
                      //   } else if (error.toString() ==
                      //       '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
                      //     // print('Wrong password provided for that user.');
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //         content: Text(
                      //             'Wrong password provided for that user.'),
                      //       ),
                      //     );
                      //   }
                      //   print("Error ${error.toString()}");
                      // }
                      // );
                    } else if (_passwordTextController.text != "admin123") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Wrong password provided for that user.'),
                        ),
                      );
                    } else {
                      // FirebaseAuth.instance.signInWithEmailAndPassword(
                      //     email: _emailTextController.text,
                      //     password: _passwordTextController.text);
                      // send to new page
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        MyRoutes.homeRoute,
                        (route) => false,
                      );
                    }
                  }),
                ],
              )),
        ),
      ),
    );
  }
}
