import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../models/institute.dart';
import '../models/rounds.dart';
import '../utils/routes.dart';

Rounds rounds = Rounds(
  firstRoundStart: Timestamp.now(),
  firstRoundEnd: Timestamp.now(),
  secondRoundStart: Timestamp.now(),
  secondRoundEnd: Timestamp.now(),
  registerStart: Timestamp.now(),
  registerEnd: Timestamp.now(),
  mockRoundStart: Timestamp.now(),
  mockRoundEnd: Timestamp.now(),
);

Future<void> _initRounds() async {
  Rounds returnValue = Rounds(
    firstRoundStart: Timestamp.now(),
    firstRoundEnd: Timestamp.now(),
    secondRoundStart: Timestamp.now(),
    secondRoundEnd: Timestamp.now(),
    registerStart: Timestamp.now(),
    registerEnd: Timestamp.now(),
    mockRoundStart: Timestamp.now(),
    mockRoundEnd: Timestamp.now(),
  );
  if (kDebugMode) {
    print("phele - $returnValue");
  }
  rounds = await FirebaseFirestore.instance.collection('Admin').get().then(
    (snapshot) {
      for (var document in snapshot.docs) {
        returnValue = Rounds.fromFirestore(document, SnapshotOptions());
      }
      return returnValue;
    }
    //   (document) {
    //     returnValue = Rounds.fromFirestore(document, SnapshotOptions());
    //   },
    ,
    onError: (e) {
      if (kDebugMode) {
        print(e);
      }
    },
  );

  if (kDebugMode) {
    print("badme - $returnValue");
  }
  // return returnValue;
}

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  void initState() {
    super.initState();
    _initRounds();
    Timer(const Duration(seconds: 3), () {
      Navigator.popAndPushNamed(
        context,
        MyRoutes.loginRoute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        color: isDarkMode
            ? Theme.of(context).primaryColor
            : Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 200,
              ),
              const Text(
                "Seat Portal",
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
