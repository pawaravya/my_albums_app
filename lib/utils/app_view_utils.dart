import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppViewUtils {
  AppViewUtils._(); // Private constructor to prevent instantiation

  static void showSnackbar({
    required String title,
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.red.shade400 : Colors.green.shade400,
      colorText: Colors.white,
      duration: duration,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      snackStyle: SnackStyle.FLOATING,
      animationDuration: const Duration(milliseconds: 500),
    );
  }
}
