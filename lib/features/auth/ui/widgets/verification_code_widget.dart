import 'package:flutter/material.dart';

class VerificationCodeWidget extends StatefulWidget {
  final void Function(String code) onCompleted;

  const VerificationCodeWidget({super.key, required this.onCompleted});

  @override
  State<VerificationCodeWidget> createState() => _VerificationCodeWidgetState();
}

class _VerificationCodeWidgetState extends State<VerificationCodeWidget> {
  final int codeLength = 6;
  final List<FocusNode> focusNodes = [];
  final List<TextEditingController> controllers = [];
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < codeLength; i++) {
      focusNodes.add(FocusNode());
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void onCodeChanged(int index, String value) {
    // faqat bitta raqam kiritish
    if (value.length > 1) {
      controllers[index].text = value.substring(value.length - 1);
      controllers[index].selection = TextSelection.fromPosition(
        TextPosition(offset: 1),
      );
    }

    // agar raqam kiritilsa, keyingi maydonga o'tish
    if (value.isNotEmpty && index < codeLength - 1) {
      focusNodes[index + 1].requestFocus();
    }

    // oxirgi raqamda fokusni o‘chirish
    if (index == codeLength - 1 && value.isNotEmpty) {
      focusNodes[index].unfocus();
    }

    // kodni tekshirish
    checkCodeStatus();
  }

  void checkCodeStatus() {
    final currentCode = controllers.map((c) => c.text).join();

    if (currentCode.length == codeLength) {
      setState(() => isButtonActive = true);
    } else {
      setState(() => isButtonActive = false);
    }
  }

  void onConfirmPressed() {
    final code = controllers.map((c) => c.text).join();

    if (code.length < codeLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kodni to‘liq kiriting!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    try {
      widget.onCompleted(code);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Xatolik yuz berdi: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Kod kiritish maydonlari
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            codeLength,
            (index) => SizedBox(
              width: 45,
              child: TextField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                onChanged: (value) => onCodeChanged(index, value),
                decoration: const InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Tasdiqlash tugmasi
        ElevatedButton(
          onPressed: isButtonActive ? onConfirmPressed : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor:
                isButtonActive ? Colors.blue : Colors.grey.shade400,
          ),
          child: const Text(
            'Confirm',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
