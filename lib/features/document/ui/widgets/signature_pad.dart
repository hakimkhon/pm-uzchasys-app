import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignaturePad extends StatefulWidget {
  final SignatureController controller;

  const SignaturePad({super.key, required this.controller});

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 220,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Signature(

            controller: widget.controller,
            backgroundColor: Colors.white,
            width: 2.5,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                widget.controller.clear();
              },
              child: const Text('Tozalash'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                // export handled by parent
              },
              child: const Text('Saqlash (oldindan)'),
            ),
          ],
        )
      ],
    );
  }
}
