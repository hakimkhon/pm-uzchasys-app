import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../widgets/signature_pad.dart';

class DocumentDetailPage extends StatefulWidget {
  final String documentTitle;

  const DocumentDetailPage({super.key, required this.documentTitle});

  @override
  State<DocumentDetailPage> createState() => _DocumentDetailPageState();
}

class _DocumentDetailPageState extends State<DocumentDetailPage> {
  final GlobalKey<SignaturePadState> _signaturePadKey =
      GlobalKey<SignaturePadState>();
  bool _hasSignature = false;

  Future<Uint8List?> _captureSignature() async {
    final state = _signaturePadKey.currentState;
    if (state == null) return null;
    return await state.captureSignature();
  }

  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();
    final signatureBytes = await _captureSignature();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              widget.documentTitle,
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Hujjat mazmuni',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'Bu yerda hujjat matni joylashadi. Hozircha namuna matn ko\'rsatilgan.',
              style: const pw.TextStyle(fontSize: 14, lineSpacing: 1.5),
            ),
            pw.SizedBox(height: 40),
            if (signatureBytes != null) ...[
              pw.Text(
                'Imzo:',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Container(
                height: 100,
                width: 250,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey),
                ),
                child: pw.Image(pw.MemoryImage(signatureBytes)),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Sana: ${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
                style: const pw.TextStyle(fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );

    return pdf.save();
  }

  Future<void> _previewAndPrintPdf() async {
    if (!_hasSignature) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Iltimos, avval imzo qo\'ying!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      final pdfData = await _generatePdf();
      if (!mounted) return;
      await Printing.layoutPdf(
        onLayout: (format) async => pdfData,
        name: '${widget.documentTitle}.pdf',
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Xatolik: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _savePdf() async {
    if (!_hasSignature) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Iltimos, avval imzo qo\'ying!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      final pdfData = await _generatePdf();
      if (!mounted) return;
      await Printing.sharePdf(
        bytes: pdfData,
        filename: '${widget.documentTitle}.pdf',
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF muvaffaqiyatli saqlandi!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Xatolik: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.documentTitle,
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.print, color: AppColors.secondaryColor),
            onPressed: _previewAndPrintPdf,
            tooltip: 'Chop etish',
          ),
          IconButton(
            icon: Icon(Icons.download, color: AppColors.secondaryColor),
            onPressed: _savePdf,
            tooltip: 'Yuklab olish',
          ),
        ],
      ),
      body: Column(
        children: [
          // Hujjat mazmuni (60%)
          Expanded(
            flex: 60,
            child: Container(
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hujjat mazmuni' /* ... */),
                    SizedBox(height: 16.h),
                    Text('Bu yerda hujjat matni...' /* ... */),
                  ],
                ),
              ),
            ),
          ),

          // Imzo qismi — 40%
          Expanded(
            flex: 40,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.primaryColor, width: 1),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 8.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Imzongizni qo\'ying',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.refresh, color: Colors.red),
                            onPressed: () {
                              _signaturePadKey.currentState?.clear();
                              setState(() => _hasSignature = false);
                            },
                          ),
                        ],
                      ),
                    ),
                    // ✅ Imzo maydoni — faqat shu yerda chiziladi
                    Expanded(
                      child: SignaturePad(
                        key: _signaturePadKey,
                        onClear: () => setState(() => _hasSignature = false),
                        onDraw: () => setState(() => _hasSignature = true),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Tasdiqlash tugmasi
          Padding(
            padding: EdgeInsets.all(12.w),
            child: SizedBox(
              width: double.infinity,
              height: 45.h,
              child: ElevatedButton.icon(
                onPressed: _hasSignature ? _previewAndPrintPdf : null,
                icon: Icon(Icons.visibility, size: 20.sp),
                label: Text('Ko\'rib chiqish va Chop etish'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
















// class DocumentDetailPage extends StatefulWidget {
//   final String documentTitle;

//   const DocumentDetailPage({
//     super.key,
//     required this.documentTitle,
//   });

//   @override
//   State<DocumentDetailPage> createState() => _DocumentDetailPageState();
// }

// class _DocumentDetailPageState extends State<DocumentDetailPage> {
//   List<Offset> _signaturePoints = [];
//   final GlobalKey _signatureKey = GlobalKey();

//   void _clearSignature() {
//     setState(() {
//       _signaturePoints.clear();
//     });
//   }

//   // Imzoni rasmga o'girish
//   Future<Uint8List?> _captureSignature() async {
//     try {
//       RenderRepaintBoundary boundary = _signatureKey.currentContext!
//           .findRenderObject() as RenderRepaintBoundary;
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData =
//           await image.toByteData(format: ui.ImageByteFormat.png);
//       return byteData?.buffer.asUint8List();
//     } catch (e) {
//       print('Imzoni olishda xatolik: $e');
//       return null;
//     }
//   }

//   // PDF yaratish
//   Future<Uint8List> _generatePdf() async {
//     final pdf = pw.Document();

//     // Imzoni olish
//     final signatureImage = await _captureSignature();

//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               // Sarlavha
//               pw.Text(
//                 widget.documentTitle,
//                 style: pw.TextStyle(
//                   fontSize: 24,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//               pw.SizedBox(height: 20),

//               // Hujjat mazmuni
//               pw.Text(
//                 'Hujjat mazmuni',
//                 style: pw.TextStyle(
//                   fontSize: 18,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//               pw.SizedBox(height: 10),
//               pw.Text(
//                 'Bu yerda hujjat matni joylashadi. Hozircha namuna matn ko\'rsatilgan. Kelajakda bu qismni real hujjat mazmuni bilan to\'ldirasiz.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
//                 style: const pw.TextStyle(
//                   fontSize: 14,
//                   lineSpacing: 1.5,
//                 ),
//               ),
//               pw.SizedBox(height: 40),

//               // Imzo
//               if (signatureImage != null) ...[
//                 pw.Text(
//                   'Imzo:',
//                   style: pw.TextStyle(
//                     fontSize: 16,
//                     fontWeight: pw.FontWeight.bold,
//                   ),
//                 ),
//                 pw.SizedBox(height: 10),
//                 pw.Container(
//                   height: 100,
//                   width: 250,
//                   decoration: pw.BoxDecoration(
//                     border: pw.Border.all(color: PdfColors.grey),
//                   ),
//                   child: pw.Image(pw.MemoryImage(signatureImage)),
//                 ),
//                 pw.SizedBox(height: 10),
//                 pw.Text(
//                   'Sana: ${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
//                   style: const pw.TextStyle(fontSize: 12),
//                 ),
//               ],
//             ],
//           );
//         },
//       ),
//     );

//     return pdf.save();
//   }

//   // PDF ko'rish va chop etish
//   Future<void> _previewAndPrintPdf() async {
//     if (_signaturePoints.isEmpty) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Iltimos, avval imzo qo\'ying!'),
//           backgroundColor: Colors.orange,
//         ),
//       );
//       return;
//     }

//     try {
//       final pdfData = await _generatePdf();
      
//       if (!mounted) return;
//       await Printing.layoutPdf(
//         onLayout: (PdfPageFormat format) async => pdfData,
//         name: '${widget.documentTitle}.pdf',
//       );
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Xatolik: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   // PDF saqlash
//   Future<void> _savePdf() async {
//     if (_signaturePoints.isEmpty) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Iltimos, avval imzo qo\'ying!'),
//           backgroundColor: Colors.orange,
//         ),
//       );
//       return;
//     }

//     try {
//       final pdfData = await _generatePdf();
      
//       if (!mounted) return;
//       await Printing.sharePdf(
//         bytes: pdfData,
//         filename: '${widget.documentTitle}.pdf',
//       );
      
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('PDF muvaffaqiyatli saqlandi!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Xatolik: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           widget.documentTitle,
//           style: TextStyle(
//             color: AppColors.secondaryColor,
//             fontSize: 20.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           // Chop etish tugmasi
//           IconButton(
//             icon: Icon(Icons.print, color: AppColors.secondaryColor),
//             onPressed: _previewAndPrintPdf,
//             tooltip: 'Chop etish',
//           ),
//           // Yuklab olish tugmasi
//           IconButton(
//             icon: Icon(Icons.download, color: AppColors.secondaryColor),
//             onPressed: _savePdf,
//             tooltip: 'Yuklab olish',
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Hujjat mazmuni qismi (60%)
//           Expanded(
//             flex: 60,
//             child: Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(20.w),
//               margin: EdgeInsets.all(16.w),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius: BorderRadius.circular(12.r),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Hujjat mazmuni',
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.secondaryColor,
//                       ),
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'Bu yerda hujjat matni joylashadi. Hozircha namuna matn ko\'rsatilgan. Kelajakda bu qismni real hujjat mazmuni bilan to\'ldirasiz.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
//                       style: TextStyle(
//                         fontSize: 15.sp,
//                         height: 1.5,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Imzo qo'yish qismi (30%)
//           Expanded(
//             flex: 30,
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12.r),
//                 border: Border.all(color: AppColors.primaryColor, width: 2),
//               ),
//               child: Column(
//                 children: [
//                   // Sarlavha va tozalash tugmasi
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Imzongizni qo\'ying',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w600,
//                             color: AppColors.secondaryColor,
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.refresh, color: Colors.red),
//                           onPressed: _clearSignature,
//                           tooltip: 'Tozalash',
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Imzo maydoni
//                   Expanded(
//                     child: GestureDetector(
//                       behavior: HitTestBehavior.translucent, // 👈 bu qatorni qo'shing
//                       onPanStart: (details) {
//                         setState(() {
//                           _signaturePoints.add(details.localPosition);
//                         });
//                       },
//                       onPanUpdate: (details) {
//                         setState(() {
//                           _signaturePoints.add(details.localPosition);
//                         });
//                       },
//                       onPanEnd: (details) {
//                         setState(() {
//                           _signaturePoints.add(Offset.infinite);
//                         });
//                       },
//                       child: CustomPaint(
//                         painter: SignaturePainter(_signaturePoints),
//                         child: Container(
//                           color: Colors.grey.shade50,
//                         ),
//                       ),
//                     ),
//                   ),

//                   // Tasdiqlash tugmasi
//                   Padding(
//                     padding: EdgeInsets.all(12.w),
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 45.h,
//                       child: ElevatedButton.icon(
//                         onPressed: _signaturePoints.isEmpty
//                             ? null
//                             : _previewAndPrintPdf,
//                         icon: Icon(Icons.visibility, size: 20.sp),
//                         label: Text(
//                           'Ko\'rib chiqish va Chop etish',
//                           style: TextStyle(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primaryColor,
//                           foregroundColor: Colors.white,
//                           disabledBackgroundColor: Colors.grey.shade300,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.r),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Imzo chizish uchun CustomPainter
// class SignaturePainter extends CustomPainter {
//   final List<Offset> points;

//   SignaturePainter(this.points);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 3.0;

//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != Offset.infinite && points[i + 1] != Offset.infinite) {
//         canvas.drawLine(points[i], points[i + 1], paint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(SignaturePainter oldDelegate) {
//     return oldDelegate.points != points;
//   }
// }