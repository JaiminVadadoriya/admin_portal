import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../main.dart';
import '../models/rounds.dart';
import '../pages/login_page.dart';
import '../process/meritpdf.dart';
import '../models/student.dart';
import '../utils/conform_institute.dart';
import 'merit.dart';

class SignoutDrawer extends StatelessWidget {
  const SignoutDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 40, 8.0, 8.0),
        child: Column(
          children: [
            SizedBox(
              child: const CircleAvatar(
                radius: 40,
                // backgroundColor: Color.fromRGBO(0, 102, 133, 1),
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    Icons.account_circle,
                    // color: Colors.white,
                    size: 80,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),

            rounds.registretionEnd(Timestamp.now())
                ? Card(
                    child: ListTile(
                      title: Text("Give Merit"),
                      onTap: () => calculateMeritList(),
                    ),
                  )
                : Card(
                    child: ListTile(
                    title: Text("Rigistretion is not end."),
                  )),

            rounds.mockroundEnds(Timestamp.now())
                ? Card(
                    child: ListTile(
                      title: Text("Mock round"),
                      onTap: () => conformInstitute(),
                    ),
                  )
                : Card(
                    child: ListTile(
                      title: Text("Mock round date hasn't come"),
                    ),
                  ),

            Card(
              child: ListTile(
                title: Text("Sign out"),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
              ),
            ),

            //   SizedBox(
            //   height: 40,
            // ),
            // ElevatedButton(
            //   // style: ButtonStyle(backgroundColor: ),
            //   onPressed: () {
            //     FirebaseAuth.instance.signOut();
            //     Navigator.push(
            //       context,
            //      MaterialPageRoute(builder: (context) => const login_page())
            //       );
            //   },
            //   child: Text("Sign out"),
            // ),
          ],
        ),
      ),
    );
  }
}
