import 'package:admin_portal/pages/login_page.dart';
import 'package:admin_portal/pages/timeSet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 4.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FittedBox(
                child: const CircleAvatar(
                  radius: 40,
                  // backgroundColor: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Text(
                "Admin",
                style: TextStyle(fontSize: 29),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                // style: ButtonStyle(backgroundColor: ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: Text("Sign out"),
              ),
            ]));
  }
}
