// import 'dart:io';

// import 'package:pdf/widgets.dart' as pw;

// import '../models/student.dart';

// Future<void> generatePdf(Student? mydata) async {
//   final pdf = pw.Document();
// // build your pdf view here
//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) => pw.Center(
//         child: pw.Text(mydata?.name ??''),
//       ),
//     ),
//   );
// //save pdf
//   final file = File('example.pdf');
//   await file.writeAsBytes(await pdf.save());
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> generatePdf() async {
  final pdf = pw.Document();

  // Fetch data from Firestore
  final querySnapshot = await FirebaseFirestore.instance.collection('students').get();
  final documents = querySnapshot.docs;

  // Loop through documents and add to PDF
  for (final doc in documents) {
    final data = doc.data();

    // Build PDF view
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text(data['name'] ?? ''),
        ),
      ),
    );
  }

  // Save PDF
  final file = File('example.pdf');
  await file.writeAsBytes(await pdf.save());
}
