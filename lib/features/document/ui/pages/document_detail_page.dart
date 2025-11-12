// lib/screens/document_detail_screen.dart

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../widgets/document/document_app_bar.dart';
import '../widgets/document/document_content.dart';
import '../widgets/document/signature_section.dart';
import '../widgets/document/preview_button.dart';
import '../widgets/signature_pad.dart';

class DocumentDetailPage extends StatefulWidget {
  final String documentTitle;

  const DocumentDetailPage({super.key, required this.documentTitle});

  @override
  State<DocumentDetailPage> createState() => _DocumentDetailPageState();
}

class _DocumentDetailPageState extends State<DocumentDetailPage> {
  final GlobalKey<SignaturePadState> _signaturePadKey = GlobalKey<SignaturePadState>();
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
            pw.Text(widget.documentTitle, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Hujjat mazmuni', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text(
              'Bu yerda hujjat matni joylashadi. Hozircha namuna matn ko\'rsatilgan. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. yana bir nechta jumlalar bilan hujjat mazmuni to\'ldiriladi. Required content to demonstrate scrolling behavior in the document content area. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Required content to demonstrate scrolling behavior in the document content area. With additional lines to ensure the content exceeds the visible area and requires scrolling. Quis do eiusmod tempor incididunt ut labore et dolore magna aliqua.',   
              style: const pw.TextStyle(fontSize: 14, lineSpacing: 1.5),
            ),
            pw.SizedBox(height: 40),
            if (signatureBytes != null) ...[
              pw.Text('Imzo:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Container(
                height: 100,
                width: 250,
                decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey)),
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
        const SnackBar(content: Text('Iltimos, avval imzo qo\'ying!'), backgroundColor: Colors.orange),
      );
      return;
    }

    try {
      final pdfData = await _generatePdf();
      if (!mounted) return;
      await Printing.layoutPdf(onLayout: (format) async => pdfData, name: '${widget.documentTitle}.pdf');
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
      appBar: DocumentAppBar(
        title: widget.documentTitle,
        onBack: () => Navigator.pop(context),
        onPrint: _previewAndPrintPdf,
        onSave: () {
          // Agar kerak bo'lsa, _savePdf() qo'shishingiz mumkin
          _previewAndPrintPdf(); // hozircha bir xil
        },
      ),
      body: Column(
        children: [
          Expanded(flex: 60, child: DocumentContent()),
          Expanded(
            flex: 40,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: SignatureSection(
                signaturePadKey: _signaturePadKey,
                onClear: () {
                  _signaturePadKey.currentState?.clear();
                  setState(() => _hasSignature = false);
                },
                onDraw: () => setState(() => _hasSignature = true),
              ),
            ),
          ),
          PreviewButton(
            onPressed: _previewAndPrintPdf,
            enabled: _hasSignature,
          ),
        ],
      ),
    );
  }
}