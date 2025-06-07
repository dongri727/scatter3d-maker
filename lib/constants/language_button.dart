import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class LanguageDropdownButton extends StatefulWidget {
  const LanguageDropdownButton({super.key});

  @override
  LanguageDropdownButtonState createState() => LanguageDropdownButtonState();
}

class LanguageDropdownButtonState extends State<LanguageDropdownButton> {
  String? currentLanguage = 'ja';// 初期値として'ja' (日本の国旗) を設定

  @override
  void initState() {
    super.initState();
    _loadLanguage();  // 起動時に言語設定を読み込む
  }

  void _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');

    // SharedPreferencesから言語が読み込めたら、それを使ってUIを更新
    if (languageCode != null) {
      setState(() {
        currentLanguage = languageCode;
      });
    }
  }

  void _changeLanguage(String languageCode) async {
    Locale newLocale = Locale(languageCode);

    // 言語を保存する
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);

    if (!mounted) return;

    MyApp.setLocale(context, newLocale); // MyApp内のsetLocaleメソッドを呼び出し

    // setStateを呼び出して、UIを更新
    setState(() {
      currentLanguage = languageCode;  // 現在の言語を更新
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(15),
      value: currentLanguage,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            currentLanguage = newValue;
            _changeLanguage(newValue);  // 選択された言語コードを_changeLanguageに渡す
          });
        }
      },
      items: <String>['en', 'ja']  // 言語コードのリスト
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value == 'en' ? 'English' : '日本語'),  // 国旗の表示
        );
      }).toList(),
    );
  }
}