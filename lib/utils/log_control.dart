import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:logging/logging.dart';

final String LOG_FILE_NAME = "trace.log";
final Level LOG_LEVEL = Level.ALL;
final int LOG_FILE_SIZE = 10; // MB
//final int LOG_FILE_NUM = 2;
final String LOG_OUTPUT_PATTERN =
    "%d [%p] [%c] : %m"; // %d:time, %p:log level, %c:class name, %m:message

final LOG_KEYWORD = ['%d', '%p', '%c', '%m'];

class _OutputPatternInfo {
  var output_order; // 表示順番
  var key_no; // キーワード番号
}

class LogControl {
  static LogControl _instance = new LogControl();
  static var keyList = <_OutputPatternInfo>[];
  static var wordList = <String>[];
  static var checkFileSizeSkip = 0;

  static LogControl getInstance() {
    return _instance;
  }

  void init() {
    Logger.root.level = LOG_LEVEL;
    _output_pattern();
    Logger.root.onRecord.listen((event) {
      _checkFileSize();
      String message = _output(event);
      // '${event.level.name}: ${event.time}: ${event.message}\r\n';
      print(message);
      _write(message);
    });
  }

  void _output_pattern() {
    //print("_output_pattern() start.");
    var key_line = [-1, -1, -1, -1];

    for (var i = 0; i < LOG_KEYWORD.length; i++) {
      key_line[i] = LOG_OUTPUT_PATTERN.indexOf(LOG_KEYWORD[i]);
    }

    for (var i = 0; i < key_line.length; i++) {
      var order = 0;
      for (var j = 0; j < key_line.length; j++) {
        if (key_line[i] == -1) continue;
        if ((key_line[i] > key_line[j]) && (key_line[j] != -1)) {
          order++;
        }
      }

      var val = _OutputPatternInfo();
      val.key_no = i;
      if (key_line[i] == -1) {
        val.output_order = -1;
        keyList.add(val);
      } else {
        val.output_order = order;
        if (keyList.length < order)
          keyList.add(val);
        else
          keyList.insert(order, val);
      }
    }

    // for (var v in keyList) {
    //   print('keylist: output_order=${v.output_order}, key_no=${v.key_no}');
    // }

    var word_start = 0;
    for (var v in keyList) {
      if (v.output_order == -1) continue;
      var word = LOG_OUTPUT_PATTERN.substring(word_start, key_line[v.key_no]);
      wordList.add(word);
      word_start = key_line[v.key_no] + 2;
    }

    // for (var v in wordList) {
    //   print('wordlist: m=${v}');
    // }

    // print("_output_pattern() end.");
  }

  String _output(event) {
    String result = '';
    var i = 0;
    for (var v in keyList) {
      if (wordList.length > i) {
        result += wordList[i];
        i++;
      }
      var key_no = v.key_no;
      if (key_no != -1) {
        switch (LOG_KEYWORD[key_no]) {
          case '%d':
            result += '${event.time}';
            break;
          case '%p':
            result += '${event.level.name}';
            break;
          case '%c':
            result += '${event.loggerName}';
            break;
          case '%m':
            result += '${event.message}';
            break;
          default:
        }
      }
    }
    if (wordList.length > i) {
      result += wordList[i];
      i++;
    }
    result += '\r\n';
    return result;
  }

  Future<String> _read() async {
    //print("read() start.");
    final directory = await getExternalStorageDirectory();
    final String? path = directory?.path;
    final file = File('$path/$LOG_FILE_NAME');
    String result = "";

    if (await file.exists()) {
      result = await file.readAsString();
      print(result);
    }
    //print("read() end.");
    return result;
  }

  void _write(String message) async {
    //print("write() start.");
    final directory = await getExternalStorageDirectory();
    final String? path = directory?.path;
    final file = File('$path/$LOG_FILE_NAME');

    if (!await file.exists()) {
      await file.create();
    }
    await file.writeAsString(message, mode: FileMode.append);
    //print("write() end.");
  }

  void delete() async {
    //print("clear() start.");
    final directory = await getExternalStorageDirectory();
    final String? path = directory?.path;
    final file = File('$path/$LOG_FILE_NAME');

    if (await file.exists()) {
      await file.delete();
    }
    //print("clear() end.");
  }

  void _checkFileSize() async {
    //print("checkFileSize() start.");
    // 毎回チェックするのは無駄なのでスキップ回数分読み飛ばし
    if (checkFileSizeSkip-- > 0) {
      return;
    }

    final directory = await getExternalStorageDirectory();
    final String? path = directory?.path;
    final file = File('$path/$LOG_FILE_NAME');

    if (await file.exists()) {
      var sizeKB = await file.length() / 1024;
      var sizeMB = sizeKB / 1024;
      //print("checkFileSize() ${sizeB}byte, ${sizeKB}KB, ${sizeMB}MB");
      // ファイルサイズチェック
      if (sizeMB > LOG_FILE_SIZE) {
        // 古いファイルを別名でコピー
        File newFile = await file.copy('$path/$LOG_FILE_NAME.1');
        if (await newFile.exists()) {
          delete(); // 古いファイル削除
        }
      } else {
        var sizeGapMB = LOG_FILE_SIZE - sizeMB;
        if (sizeGapMB > 0) {
          checkFileSizeSkip = 10000; // １万回スキップ
        } else {
          var sizeGapKB = LOG_FILE_SIZE * 1024 - sizeKB;
          if (sizeGapKB > 100) {
            checkFileSizeSkip = 1000; // 1000回スキップ
          } else if ((sizeGapKB <= 100) && (sizeGapKB > 10)) {
            checkFileSizeSkip = 100; // 100回スキップ
          } else if ((sizeGapKB <= 10) && (sizeGapKB > 1)) {
            checkFileSizeSkip = 10; // 10回スキップ
          }
        }
      }
    }
    //print("checkFileSize() end.");
  }
}