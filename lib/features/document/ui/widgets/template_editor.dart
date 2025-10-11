// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:signature/signature.dart';
// import '../../../../constants/app_colors.dart';
// import 'signature_pad.dart';
// import 'pdf_service.dart';
// import 'package:flutter/services.dart';

// class TemplateEditorPage extends StatefulWidget {
//   final String templateId;
//   final String templateTitle;
//   final String templateAsset; // asset image shown as template background

//   const TemplateEditorPage({
//     super.key,
//     required this.templateId,
//     required this.templateTitle,
//     required this.templateAsset,
//   });

//   @override
//   State<TemplateEditorPage> createState() => _TemplateEditorPageState();
// }

// class _TemplateEditorPageState extends State<TemplateEditorPage> {
//   final SignatureController _sigController = SignatureController(
//     penStrokeWidth: 2.5,
//     penColor: Colors.black,
//   );
//   // position of signature on preview widget (in logical pixels)
//   double _sigLeft = 80;
//   double _sigTop = 400;
//   double _sigWidth = 160;
//   bool _signaturePlaced = false;

//   // convert signature to PNG bytes
//   Future<Uint8List?> _exportSignature() async {
//     if (_sigController.isEmpty) return null;
//     final ui.Image? exported = await _sigController.toImage(
//       // pixelRatio: 3.0,
//     );
//     final ByteData? bytes = await exported?.toByteData(
//       format: ui.ImageByteFormat.png,
//     );
//     return bytes?.buffer.asUint8List();
//   }

//   // generate PDF using PdfService
//   Future<void> _generatePdf() async {
//     final sigBytes = await _exportSignature();
//     if (sigBytes == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Iltimos, avvalo imzo chizing')),
//       );
//       return;
//     }

//     // load template image to get scale and compute position in PDF points
//     final ByteData tmplData = await rootBundle.load(widget.templateAsset);
//     final Uint8List tmplBytes = tmplData.buffer.asUint8List();
//     // For simplicity we place signature using relative scale:
//     // assume preview width corresponds to A4 width in points
//     // get device preview width
//     final renderBox =
//         _previewKey.currentContext?.findRenderObject() as RenderBox?;
//     if (renderBox == null) return;
//     final previewWidth = renderBox.size.width;
//     final previewHeight = renderBox.size.height;

//     // PDF page size in points
//     final pdfWidth = pwPageWidth;
//     final pdfHeight = pwPageHeight;

//     // compute scale factor
//     final scaleX = pdfWidth / previewWidth;
//     final scaleY = pdfHeight / previewHeight;

//     // compute final signature position in PDF points
//     final double pdfSigX = _sigLeft * scaleX;
//     final double pdfSigY = _sigTop * scaleY;
//     final double pdfSigWidth = _sigWidth * scaleX;

//     final savedPath = await PdfService.createPdfWithSignature(
//       templateAsset: widget.templateAsset,
//       signatureBytes: sigBytes,
//       sigX: pdfSigX,
//       sigY: pdfSigY,
//       sigWidth: pdfSigWidth,
//     );

//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('Saqlangan: $savedPath')));
//   }

//   // A4 in points (pdf package uses points)
//   static const double pwPageWidth = 595.0; // A4 width in points ~ 595
//   static const double pwPageHeight = 842.0; // A4 height in points ~ 842

//   final GlobalKey _previewKey = GlobalKey();

//   @override
//   void dispose() {
//     _sigController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // preview area shows template image and movable signature box
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.templateTitle),
//         backgroundColor: AppColors.white,
//         foregroundColor: AppColors.secondaryColor,
//         actions: [
//           IconButton(icon: const Icon(Icons.save), onPressed: _generatePdf),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(12.w),
//         child: Column(
//           children: [
//             // Preview area
//             Expanded(
//               child: Center(
//                 child: AspectRatio(
//                   aspectRatio: pwPageWidth / pwPageHeight,
//                   child: Container(
//                     key: _previewKey,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300),
//                     ),
//                     child: Stack(
//                       children: [
//                         // template background
//                         Positioned.fill(
//                           child: Image.asset(
//                             widget.templateAsset,
//                             fit: BoxFit.cover,
//                           ),
//                         ),

//                         // movable signature preview (draggable)
//                         Positioned(
//                           left: _sigLeft,
//                           top: _sigTop,
//                           child: GestureDetector(
//                             onPanUpdate: (details) {
//                               setState(() {
//                                 _sigLeft = (_sigLeft + details.delta.dx).clamp(
//                                   0.0,
//                                   (MediaQuery.of(context).size.width -
//                                       _sigWidth),
//                                 );
//                                 _sigTop = (_sigTop + details.delta.dy).clamp(
//                                   0.0,
//                                   (MediaQuery.of(context).size.height - 100.0),
//                                 );
//                                 _signaturePlaced = true;
//                               });
//                             },
//                             child: Container(
//                               width: _sigWidth,
//                               height: _sigWidth * 0.35,
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.9),
//                                 border: Border.all(color: Colors.black12),
//                               ),
//                               child: _sigController.isEmpty
//                                   ? Center(
//                                       child: Text(
//                                         'Imzo yo‘q',
//                                         style: TextStyle(
//                                           color: Colors.grey.shade600,
//                                         ),
//                                       ),
//                                     )
//                                   : FutureBuilder<Uint8List?>(
//                                       future: _sigController.toPngBytes(),
//                                       builder: (context, snap) {
//                                         if (!snap.hasData)
//                                           return const SizedBox.shrink();
//                                         return Image.memory(
//                                           snap.data!,
//                                           fit: BoxFit.contain,
//                                         );
//                                       },
//                                     ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 12),

//             // signature pad
//             SignaturePad(controller: _sigController),

//             const SizedBox(height: 12),

//             // width slider for signature preview
//             Row(
//               children: [
//                 const Text('Imzo kengligi:'),
//                 Expanded(
//                   child: Slider(
//                     value: _sigWidth,
//                     min: 80,
//                     max: 300,
//                     onChanged: (v) => setState(() => _sigWidth = v),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 8),

//             // buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     icon: const Icon(Icons.place),
//                     label: const Text('Sign joylash'),
//                     onPressed: () {
//                       // toggles preview placement mode
//                       setState(() {
//                         _signaturePlaced = !_signaturePlaced;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     icon: const Icon(Icons.picture_as_pdf),
//                     label: const Text('PDF yaratish'),
//                     onPressed: _generatePdf,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
