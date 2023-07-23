import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin Utils{
  static void showSnackBar(String message){
    Get.rawSnackbar(
        borderRadius: 8,
        backgroundColor: const Color(0xFF1D1D1D),
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
        message: message,
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.TOP
    );
  }
}