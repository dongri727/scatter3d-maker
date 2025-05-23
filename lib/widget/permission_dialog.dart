import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class PermissionRequester {
  /// 指定したパーミッションの状態を確認し、未許可ならダイアログを表示する
  static Future<bool> requestPermission({
    required BuildContext context,
    required Permission permission,
    required String title,
    required String message,
  }) async {
    final status = await permission.status;

    if (status.isGranted) return true;

    final result = await permission.request();

    if (result.isGranted) return true;

    // ダイアログを表示してユーザーに設定を促す
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
            child: Text(AppLocalizations.of(context)!.permissionC),
          ),
        ],
      ),
    );

    return false;
  }
}