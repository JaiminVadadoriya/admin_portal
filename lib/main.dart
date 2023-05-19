import 'package:admin_portal/pages/home_page.dart';
import 'package:admin_portal/utils/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:admin_portal/pages/login_page.dart';

import 'models/rounds.dart';

late Rounds rounds = Rounds(
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
  print("phele - ${returnValue}");
  await FirebaseFirestore.instance.collection('Admin').get().then(
    (snapshot) {
      for (var document in snapshot.docs) {
        rounds = Rounds.fromFirestore(document, SnapshotOptions());
      }
      return returnValue;
    }
    //   (document) {
    //     returnValue = Rounds.fromFirestore(document, SnapshotOptions());
    //   },
    ,
    onError: (e) {
      print(e);
    },
  );

  print("badme - ${returnValue}");
  // return returnValue;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _initRounds();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        // theme: ThemeData(
        //   // This is the theme of your application.
        //   //
        //   // Try running your application with "flutter run". You'll see the
        //   // application has a blue toolbar. Then, without quitting the app, try
        //   // changing the primarySwatch below to Colors.green and then invoke
        //   // "hot reload" (press "r" in the console where you ran "flutter run",
        //   // or simply save your changes to "hot reload" in a Flutter IDE).
        //   // Notice that the counter didn't reset back to zero; the application
        //   // is not restarted.
        //   primarySwatch: Colors.blue,
        // ),
        themeMode: ThemeMode.system,
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        debugShowCheckedModeBanner: false,
        // home: const login_page(),
        routes: {"/": (context) => const Login()});
  }
}
