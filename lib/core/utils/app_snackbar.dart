import 'package:flutter/material.dart';

class AppSnackBar {
  static void show(
    BuildContext context, {
    required String key,
    required String value,
  }) {
    final config = _getSnackConfig(key);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: config.backgroundColor,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Row(
          children: [
            Icon(config.icon, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static _SnackConfig _getSnackConfig(String key) {
    switch (key.toLowerCase()) {
      case 'success':
        return _SnackConfig(
          backgroundColor: Colors.green,
          icon: Icons.check_circle,
        );
      case 'error':
        return _SnackConfig(
          backgroundColor: Colors.redAccent,
          icon: Icons.error,
        );
      case 'warning':
        return _SnackConfig(
          backgroundColor: Colors.orange,
          icon: Icons.warning,
        );
      case 'info':
        return _SnackConfig(
          backgroundColor: Colors.blue,
          icon: Icons.info,
        );
      default:
        return _SnackConfig(
          backgroundColor: Colors.grey.shade700,
          icon: Icons.message,
        );
    }
  }
}

class _SnackConfig {
  final Color backgroundColor;
  final IconData icon;

  const _SnackConfig({
    required this.backgroundColor,
    required this.icon,
  });
}
