// lib/widgets/signature_pad.dart

import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../constants/app_colors.dart';

class SignaturePad extends StatefulWidget {
  final VoidCallback onClear;
  final VoidCallback onDraw;

  const SignaturePad({
    super.key,
    required this.onClear,
    required this.onDraw,
  });

  @override
  SignaturePadState createState() => SignaturePadState();
}

class SignaturePadState extends State<SignaturePad> {
  List<Offset> _points = [];
  final GlobalKey _repaintKey = GlobalKey();

  List<Offset> get points => _points;
  GlobalKey get repaintKey => _repaintKey;

  void clear() {
    setState(() {
      _points = [];
    });
  }

  Future<Uint8List?> captureSignature() async {
    try {
      final boundary = repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('Imzo olishda xatolik: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _repaintKey,
      child: Container(
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue, width: 1),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanStart: (details) {
                final box = context.findRenderObject() as RenderBox;
                final local = box.globalToLocal(details.globalPosition);
                debugPrint('Chizish boshlandi: $local | Constraints: ${constraints.maxWidth}x${constraints.maxHeight}');

                // Aniqlik uchun: constraints ichida ekanligini tekshiramiz
                if (local.dx >= 0 &&
                    local.dy >= 0 &&
                    local.dx <= constraints.maxWidth &&
                    local.dy <= constraints.maxHeight) {
                  setState(() {
                    if (_points.isNotEmpty && _points.last != Offset.infinite) {
                      _points.add(Offset.infinite);
                    }
                    _points.add(local);
                  });
                }
              },
              onPanUpdate: (details) {
                final box = context.findRenderObject() as RenderBox;
                final local = box.globalToLocal(details.globalPosition);

                if (local.dx >= 0 &&
                    local.dy >= 0 &&
                    local.dx <= constraints.maxWidth &&
                    local.dy <= constraints.maxHeight) {
                  setState(() {
                    _points.add(local);
                  });
                }
              },
              onPanEnd: (details) {
                setState(() {
                  if (_points.isNotEmpty && _points.last != Offset.infinite) {
                    _points.add(Offset.infinite);
                  }
                });
                widget.onDraw();
              },
              child: CustomPaint(
                painter: SignaturePainter(_points),
                child: const SizedBox.expand(), // ⭐ Bu juda muhim!
              ),
            );
          },
        ),
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  final List<Offset> points;

  SignaturePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final paint = Paint()
      ..color = AppColors.primaryColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    Offset? lastPoint;
    for (var i = 0; i < points.length; i++) {
      final point = points[i];
      if (point == Offset.infinite) {
        lastPoint = null;
        continue;
      }
      if (lastPoint != null) {
        canvas.drawLine(lastPoint, point, paint);
      }
      lastPoint = point;
    }
  }

  @override
  bool shouldRepaint(SignaturePainter old) => old.points != points;
}