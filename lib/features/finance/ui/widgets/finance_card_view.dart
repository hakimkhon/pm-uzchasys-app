import 'package:flutter/material.dart';

class FinanceCardView extends StatelessWidget {
  final PageController controller;
  final List<String> items;
  final Map<String, String> dataMap;
  final ValueChanged<int> onPageChanged;

  const FinanceCardView({
    super.key,
    required this.controller,
    required this.items,
    required this.dataMap,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: PageView.builder(
        controller: controller,
        itemCount: items.length,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Scrollbar(
              thumbVisibility: true,
              radius: const Radius.circular(8),
              child: SingleChildScrollView(
                child: Text(
                  dataMap[items[index]]!,
                  style: const TextStyle(fontSize: 14, height: 1.4),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
