
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue, width: 1),
      ),
      child: RepaintBoundary(
        key: _repaintKey,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanStart: (details) {
            RenderBox box = context.findRenderObject() as RenderBox;
            Offset local = box.globalToLocal(details.globalPosition);
            // Faqat Container ichidagi nuqtalarni qabul qilish
            if (local.dx >= 0 && local.dy >= 0 && local.dx <= box.size.width && local.dy <= box.size.height) {
              setState(() {
                _points = [local];
              });
            }
          },
          onPanUpdate: (details) {
            RenderBox box = context.findRenderObject() as RenderBox;
            Offset local = box.globalToLocal(details.globalPosition);
            // Chegaraga tushsa, chizishni to'xtatish
            if (local.dx >= 0 && local.dy >= 0 && local.dx <= box.size.width && local.dy <= box.size.height) {
              setState(() {
                _points = List.from(_points)..add(local);
              });
            }
          },
          onPanEnd: (details) {
            if (_points.isNotEmpty) widget.onDraw();
          },
          child: CustomPaint(
            painter: SignaturePainter(_points),
            child: Container(
              color: Colors.white10,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
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
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i].isFinite && points[i + 1].isFinite) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter old) => old.points != points;
}