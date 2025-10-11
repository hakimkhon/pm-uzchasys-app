// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// class PdfService {
//   // templateAsset: path to an image asset that visually represents the document (A4 background)
//   // signatureBytes: Uint8List of PNG signature
//   // sigX, sigY in points relative to page (0..page width/height)
//   static Future<String> createPdfWithSignature({
//     required String templateAsset,
//     required Uint8List signatureBytes,
//     required double sigX,
//     required double sigY,
//     double sigWidth = 150,
//   }) async {
//     final pdf = pw.Document();

//     // load template image bytes
//     final ByteData tmplData = await rootBundle.load(templateAsset);
//     final Uint8List tmplBytes = tmplData.buffer.asUint8List();

//     final image = pw.MemoryImage(tmplBytes);
//     final sigImage = pw.MemoryImage(signatureBytes);

//     // create single page A4
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Stack(
//             children: [
//               // background template full page
//               pw.Positioned(
//                 left: 0,
//                 top: 0,
//                 child: pw.Image(image, width: PdfPageFormat.a4.width),
//               ),
//               // signature positioned
//               pw.Positioned(
//                 left: sigX,
//                 top: sigY,
//                 child: pw.Image(sigImage, width: sigWidth),
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     final bytes = await pdf.save();

//     // save to app documents directory
//     final dir = await getApplicationDocumentsDirectory();
//     final path = '${dir.path}/document_signed_${DateTime.now().millisecondsSinceEpoch}.pdf';
//     final file = File(path);
//     await file.writeAsBytes(bytes);

//     return path; // return saved file path
//   }

//   // helper: open print/share dialog
//   static Future<void> sharePdf(Uint8List pdfBytes) async {
//     await Printing.sharePdf(bytes: pdfBytes, filename: 'document_signed.pdf');
//   }
// }
