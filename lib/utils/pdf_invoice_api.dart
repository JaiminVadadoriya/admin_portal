// import 'dart:io';
// // import '../model/customer.dart';
// // import '../model/invoice.dart';
// // import '../model/supplier.dart';
// // import '../utils.dart';
// import 'package:admin_portal/utils/pdf_api.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';

// class PdfInvoiceApi {
//   static Future<File> generate(Invoice invoice) async {
//     final pdf = Document();

//     pdf.addPage(MultiPage(
//       build: (context) => [
//         // buildTitle(invoice),
//         SizedBox(height: 3 * PdfPageFormat.cm),
//         buildInvoice(invoice),
//         Divider(),
//         // buildTotal(invoice),
//       ],
//       // footer: (context) => buildFooter(invoice),
//     ));

//     return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
//   }

//   static Widget buildInvoice(Invoice invoice) {
//     final headers = [
//       'Merit no',
//       'Name',
//       'Seat no',
//       'Institute name',
//       'Institute branch',
//       'Total'
//     ];
//     final data = invoice.items.map((item) {
//       final total = item.unitPrice * item.quantity * (1 + item.vat);

//       return [
//         item.description,
//         Utils.formatDate(item.date),
//         '${item.quantity}',
//         '\$ ${item.unitPrice}',
//         '${item.vat} %',
//         '\$ ${total.toStringAsFixed(2)}',
//       ];
//     }).toList();

//     return Table.fromTextArray(
//       headers: headers,
//       data: data,
//       border: null,
//       headerStyle: TextStyle(fontWeight: FontWeight.bold),
//       headerDecoration: BoxDecoration(color: PdfColors.grey300),
//       cellHeight: 30,
//       cellAlignments: {
//         0: Alignment.centerLeft,
//         1: Alignment.centerRight,
//         2: Alignment.centerRight,
//         3: Alignment.centerRight,
//         4: Alignment.centerRight,
//         5: Alignment.centerRight,
//       },
//     );
//   }
// }

// class Utils {
//   static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
//   static formatDate(DateTime date) => DateFormat.yMd().format(date);
// }
