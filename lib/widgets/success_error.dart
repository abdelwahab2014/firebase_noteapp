
// Error message show
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void error(String message) {
    Get.snackbar(
      message,
      "",
      icon: const Icon(Icons.error_outline_outlined, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  // success message show
void success(String message) {
    Get.snackbar(
      message,
      "",
      icon: const Icon(Icons.error_outline_outlined, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }