import 'package:flutter/material.dart';

// 共通のメッセンジャーキー
final GlobalKey<ScaffoldMessengerState> _messengerKey = GlobalKey<ScaffoldMessengerState>();

class SuccessSnackBar extends SnackBar {
  static GlobalKey<ScaffoldMessengerState> get messengerKey => _messengerKey;

  SuccessSnackBar({super.key, required String message}) : super(
    content: Text(message),
    backgroundColor: Colors.teal,
    duration: const Duration(seconds: 3),
  );

  static void show(String message) {
    _messengerKey.currentState?.showSnackBar(
      SuccessSnackBar(message: message),
    );
  }
}

class FailureSnackBar extends SnackBar {
  static GlobalKey<ScaffoldMessengerState> get messengerKey => _messengerKey;

  FailureSnackBar({super.key, required String message}) : super(
    content: Text(message),
    backgroundColor: Colors.deepOrange,
    duration: const Duration(seconds: 3),
  );

  static void show(String message) {
    _messengerKey.currentState?.showSnackBar(
      FailureSnackBar(message: message),
    );
  }
}
