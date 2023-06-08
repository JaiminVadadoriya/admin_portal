import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/institute.dart';
import '../models/student.dart';

Future conformInstitute() async {
  final db = FirebaseFirestore.instance;

  List<Institute> instituteData = [];

  FirebaseFirestore.instance.collection('institutes').get().then(
    (instValue) {
      for (final instituteDocument in instValue.docs) {
        FirebaseFirestore.instance
            .collection('institutes')
            .doc(instituteDocument.id)
            .collection('branch')
            .get()
            .then(
          (branchValue) {
            List<Branch> branches = branchValue.docs
                .map((element) =>
                    Branch.fromFirestore(element, SnapshotOptions()))
                .toList();

            Institute temp =
                Institute.fromFirestore(instituteDocument, SnapshotOptions());
            temp.branches = branches;
            instituteData.add(temp);
          },
        );
      }

      // Fetch all the students from Firestore
      final studentRef = db.collection("students");
      studentRef
          .where("isSeatConf", isNotEqualTo: true)
          .orderBy("meritNo")
          .get()
          .then(
        (stuValue) {
          final students = //Student.fromMap(userData);
              stuValue.docs.map((doc) => Student.fromMap(doc.data())).toList();

          // String instiname = "";
          // String branchname = "";

          print("hello - done${students.length}");
          for (int i = 0; i < students.length; i++) {
            bool confirmed = false;

            int currentMerit = students[i].meritNo;

            for (int j = 0; j < students[i].fav.length; j++) {
              String currentFav = students[i].fav[j].substring(28);
              for (int z = 0; z < instituteData.length; z++) {
                if (students[i].fav[j].substring(0, 20) ==
                    instituteData[z].uid) {
                  for (int x = 0; x < instituteData[z].branches.length; x++) {
                    if (currentFav == instituteData[z].branches[x].bID) {
                      String instiname = instituteData[z].name;
                      String branchname =
                          instituteData[z].branches[x].branchName;
                      String stuname = students[i].name;
                      // int currentSeats =
                      //     instituteData[z].branches[x].filledSeats;
                      // int totalSeats = ;
                      // print(currentSeats);
                      // print(totalSeats);
                      print(currentMerit);

                      if (instituteData[z].branches[x].filledSeats <
                          instituteData[z].branches[x].totalSeats) {
                        // Update the favorite institute branch of the student
                        // String favInstitute =
                        //     currentFav == instituteData[z].branches[x].bID
                        //         ? currentFav
                        //         : "";
                        studentRef.doc(students[i].uid).update(
                            {'confbranch': instituteData[z].branches[x].bID});
                        studentRef
                            .doc(students[i].uid)
                            .update({'confinstitute': instituteData[z].uid});

                        print(
                            'You have successfully confirmed your institute branch.');
                        confirmed = true;

                        instituteData[z].branches[x].filledSeats++;

                        // Increment the seats in the branch document within the institute collection
                        if (instituteData[z].branches[x].minMarks <
                            students[i].meritNo) {
                          instituteData[z].branches[x].minMarks =
                              students[i].meritNo;
                          print("$stuname get this $instiname in $branchname");

                          db
                              .collection("institutes")
                              .doc(instituteData[z].uid)
                              .collection("branch")
                              .doc(instituteData[z].branches[x].bID)
                              .update({
                            'minMarks': instituteData[z].branches[x].minMarks
                          });
                        }

                        print(
                            'You have successfully confirmed your institute branch.');
                        confirmed = true;
                        // break;
                      } else {
                        print(
                            'Your merit number is not within the available seats for this institute branch. Please wait for next round.');
                        confirmed = false;
                      }
                    }
                    // if (instituteData[z].branches[x].minMarks == 0) {
                    //   instituteData[z].branches[x].minMarks = students.length;
                    //   db
                    //       .collection("institutes")
                    //       .doc(instituteData[z].uid)
                    //       .collection("branch")
                    //       .doc(instituteData[z].branches[x].bID)
                    //       .update({'minMarks': students.length});
                    // }
                    if (confirmed) {
                      break;
                    }
                  }
                  if (confirmed) {
                    break;
                  }
                }
              }
              if (confirmed) {
                break;
              }
            }
            //   if (confirmed) {
            //     break;
            //  }
          }
        },
      );
    },
  );

  // return instiname + branchname;
}
