import 'package:flutter/material.dart';

Future<void> showAlertDialog({
  required BuildContext context,
  String title = '確認',
  String content = '',
  String confirmText = 'OK',
  String cancelText = 'キャンセル',
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // ダイアログ外タップで閉じない
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text(cancelText),
            onPressed: () {
              Navigator.of(context).pop();
              if (onCancel != null) onCancel();
            },
          ),
          ElevatedButton(
            child: Text(confirmText),
            onPressed: () {
              Navigator.of(context).pop();
              if (onConfirm != null) onConfirm();
            },
          ),
        ],
      );
    },
  );
}