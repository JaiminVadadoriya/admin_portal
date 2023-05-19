import 'package:admin_portal/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../login/Reuable_Widgets.dart';
import 'package:intl/intl.dart';

import '../models/admin.dart';
import '../models/rounds.dart';

class timeSet_Page extends StatefulWidget {
  timeSet_Page({super.key});

  @override
  State<timeSet_Page> createState() => _timeSet_PageState();
}

class _timeSet_PageState extends State<timeSet_Page> {
  // late final  retrievedText;
  Future<void> _refreshRounds() async {
    print("phele - ${rounds}");
    await FirebaseFirestore.instance.collection('Admin').get().then(
      (snapshot) {
        for (var document in snapshot.docs) {
          setState(() {
            rounds = Rounds.fromFirestore(document, SnapshotOptions());
            firstroundstart = rounds.firstRoundStart.toDate();
            firstroundend = rounds.firstRoundEnd.toDate();

            mockroundstart = rounds.mockRoundStart.toDate();
            mockroundend = rounds.mockRoundEnd.toDate();

            secondroundstart = rounds.secondRoundStart.toDate();
            secondroundend = rounds.secondRoundEnd.toDate();

            registerstart = rounds.registerStart.toDate();
            registerend = rounds.registerEnd.toDate();
          });
        }
      }
      //   (document) {
      //     returnValue = Rounds.fromFirestore(document, SnapshotOptions());
      //   },
      ,
      onError: (e) {
        print(e);
      },
    );

    print("badme - ${rounds}");
    // return returnValue;
  }

  @override
  void initState() {
    super.initState();
    _refreshRounds();
    setState(() {});
    // retrievedText={};
    // currTime();
  }

//   Future<void> currTime() async {

//  // try {
//       FirebaseFirestore firestore = FirebaseFirestore.instance;

//      DocumentSnapshot documentSnapshot = await firestore
//           .collection('admin')
//           .doc('CFztGK2pWcPnlB55CRm1')
//           .get();

//       // final fetc= await firestore
//       //     .collection('admin')
//       //     .doc('CFztGK2pWcPnlB55CRm1')
//       //     .get();

//           //final fetcData= Rounds.fromFirestore(fetc, SnapshotOptions() );

//          //  retrievedText = fetcData;

//       if (documentSnapshot.exists) {
//     //     //Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

//         setState(() {
//           retrievedText = documentSnapshot.data() as Map<String, dynamic>;
//         });
//     //   }
//     // } catch(e) {
//     //   setState(() {
//     //     print('Error fetching admin data: $e');
//     //   });
//     }
//     }

  final db = FirebaseFirestore.instance;
  // DateTime datetime = DateTime.fromMicrosecondsSinceEpoch(
  //     rounds.registerStart.microsecondsSinceEpoch);

  final _formKey = GlobalKey<FormState>();
  DateTime firstroundstart = rounds.firstRoundStart.toDate();
  DateTime firstroundend = rounds.firstRoundEnd.toDate();

  DateTime mockroundstart = rounds.mockRoundStart.toDate();
  DateTime mockroundend = rounds.mockRoundEnd.toDate();

  DateTime secondroundstart = rounds.secondRoundStart.toDate();
  DateTime secondroundend = rounds.secondRoundEnd.toDate();

  DateTime registerstart = rounds.registerStart.toDate();
  DateTime registerend = rounds.registerEnd.toDate();

  @override
  Widget build(BuildContext context) {
    //currTime();

    // Admin admin= Admin.fromFirestore(snapshot, options)
    // final hours = datetime.hour.toString().padLeft(2, '0');
    // final minutes = datetime.minute.toString().padLeft(2, '0');

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                child: Column(children: [
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Register Start Date:"),
                          subtitle: Text(
                              "${registerstart.year}/${registerstart.month}/${registerstart.day}  ${registerstart.hour}:${registerend.minute}"),
                          onTap: () async {
                            final date = await pickDateTime(
                                "registerStart", rounds.registerStart);
                            // if(date==null ) return;
                            // setState(() => //datetime = date
                            //     // registerstartController.text =
                            //     //     datetime.toString()
                            //         );
                          },
                        )
                      ],
                    ),
                  ),

                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Register End Date:"),
                          subtitle: Text(
                              "${registerend.year}/${registerend.month}/${registerend.day}  ${registerend.hour}:${registerend.minute}"),
                          onTap: () async {
                            final date = await pickDateTime(
                                "registerEnd", rounds.registerEnd);
                            // if(date==null ) return;
                            // setState(() => //datetime = date
                            //     registerendController.text =
                            //         datetime.toString());
                          },
                        )
                      ],
                    ),
                  ),

                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Mock Start Date:"),
                          subtitle: Text(
                              "${mockroundstart.year}/${mockroundstart.month}/${mockroundstart.day}  ${mockroundstart.hour}:${mockroundstart.minute}"),
                          onTap: () async {
                            final date = await pickDateTime(
                                "mockRoundStart", rounds.mockRoundStart);
                            // if(date==null ) return;
                            // setState(() => //datetime = date
                            //     mockroundstartController.text =
                            //         datetime.toString());
                          },
                        )
                      ],
                    ),
                  ),

                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Mock End Date:"),
                          subtitle: Text(
                              "${mockroundend.year}/${mockroundend.month}/${mockroundend.day}  ${mockroundend.hour}:${mockroundend.minute}"),
                          onTap: () async {
                            final date = await pickDateTime(
                                "mockRoundEnd", rounds.mockRoundEnd);
                            // if(date==null ) return;
                            // setState(() => //datetime = date
                            //     mockroundendController.text =
                            //         datetime.toString());
                          },
                        )
                      ],
                    ),
                  ),

                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("First round Start Date:"),
                          subtitle: Text(
                              "${firstroundstart.year}/${firstroundstart.month}/${firstroundstart.day}  ${firstroundstart.hour}:${firstroundstart.minute}"),
                          onTap: () async {
                            final date = await pickDateTime(
                                "firstRoundStart", rounds.firstRoundStart);
                            // if(date==null ) return;
                            // setState(() => //datetime = date
                            //     firstroundstartController.text =
                            //         datetime.toString());
                          },
                        )
                      ],
                    ),
                  ),

                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("First round End Date:"),
                          subtitle: Text(
                              "${firstroundend.year}/${firstroundend.month}/${firstroundend.day}  ${firstroundend.hour}:${firstroundend.minute}"),
                          onTap: () async {
                            final date = await pickDateTime(
                                "firstRoundEnd", rounds.firstRoundEnd);
                            // if(date==null ) return;
                            // setState(() => //datetime = date
                            //     firstroundendController.text =
                            //         datetime.toString());
                          },
                        )
                      ],
                    ),
                  ),

                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Secund round Start Date:"),
                          subtitle: Text(
                              "${secondroundstart.year}/${secondroundstart.month}/${secondroundstart.day}  ${secondroundstart.hour}:${secondroundstart.minute}"),
                          onTap: () async {
                            final date = await pickDateTime(
                                "secondRoundStart", rounds.secondRoundStart);
                            // if(date==null ) return;
                            // setState(() => //datetime = date
                            //     secondroundstartController.text =
                            //         datetime.toString());
                          },
                        )
                      ],
                    ),
                  ),

                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Secund round End Date:"),
                          subtitle: Text(
                              "${secondroundend.year}/${secondroundend.month}/${secondroundend.day}  ${secondroundend.hour}:${secondroundend.minute}"),
                          onTap: () async {
                            final date = await pickDateTime(
                                "secondRoundEnd", rounds.secondRoundEnd);
                            // if(date==null ) return;
                            // setState(() => //datetime = date
                            //     secondroundendController.text =
                            //         datetime.toString());
                          },
                        )
                      ],
                    ),
                  ),

                  ///somthing
                  // ElevatedButton(

                  //   child: Text('${datetime.year}/${datetime.month}/${datetime.day}  $hours:$minutes'),

                  //   onPressed: () async {
                  //     final date =await pickDateTime();
                  //       // if(date==null ) return;
                  //       setState(() => //datetime = date
                  //        registerendController.text=datetime.toString()
                  //        );

                  //   }
                  // ),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (_formKey.currentState!.validate()) {
                  //       //save data

                  //       //  db.collection("Admin").add({
                  //       // "registerEnd": DateTime.parse(registerendController.text),
                  //       // //"registerStart": DateTime.parse(registerstartController.text),

                  //       //  });
                  //       db
                  //           .collection("Admin")
                  //           .doc("CFztGK2pWcPnlB55CRm1")
                  //           .update({
                  //         "registerEnd":
                  //             DateTime.parse(registerendController.text),
                  //         "registerStart":
                  //             DateTime.parse(registerstartController.text),
                  //         "mockRoundStart":
                  //             DateTime.parse(mockroundstartController.text),
                  //         "mockRoundEnd":
                  //             DateTime.parse(mockroundendController.text),
                  //         "firstRoundStart":
                  //             DateTime.parse(firstroundstartController.text),
                  //         "firstRoundEnd":
                  //             DateTime.parse(firstroundendController.text),
                  //         "secondRoundStart":
                  //             DateTime.parse(secondroundstartController.text),
                  //         "secondRoundEnd":
                  //             DateTime.parse(secondroundendController.text),
                  //       });
                  //     }
                  //   },
                  //   child: Text("Submit"),
                  // ),
                ])),
          ],
        )));
  }

  Future pickDateTime(String updateName, Timestamp timestamp) async {
    DateTime? date = await pickDate(timestamp);
    if (date == null) return null;

    TimeOfDay? time = await pickTime(timestamp);
    if (time == null) return;

    final _dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    db
        .collection("Admin")
        .doc("CFztGK2pWcPnlB55CRm1")
        .update({updateName: Timestamp.fromDate(_dateTime)});

    setState(() {
      _dateTime;
    });
  }

  Future<DateTime?> pickDate(Timestamp timestamp) => showDatePicker(
      context: context,
      initialDate: timestamp.toDate(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> pickTime(Timestamp timestamp) => showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: timestamp.toDate().hour, minute: timestamp.toDate().minute));
}
