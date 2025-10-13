// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get hintA => '表示例';

  @override
  String get hintB => '設定方法';

  @override
  String get hintC => 'データ形式';

  @override
  String get hintD => 'あなたのCSVデータを、こんなふうに可視化します';

  @override
  String get hintE => '入力画面で';

  @override
  String get hintF => 'assets/images/ja.jpg';

  @override
  String get hintG => '各軸の設定';

  @override
  String get hintH => '①項目名：軸に添える名称\n\n②最大値：目盛りの最大値\n(データの最大値より大きく）\n\n③最小値：目盛りの最小値。マイナスも可\n（データの最小値より小さく）\n\n※全て必須、※最大値>最小値';

  @override
  String get hintI => 'ExcelやNumbersでつくったデータをCSVで書き出します。\n\nidは各データの表示名、番号でも名前でも。\n\nx,y,zはデータの座標、\n整数でも小数でも、プラスでもマイナスでも。\n\nColorはシンプルな色名を英語で、\n単色も可。\n\nsizeは10、20, 30のいずれか。統一してもよい。\nサンプル画像の一番小さいドットが10です。';

  @override
  String get homeA => '基本設定とファイル選択';

  @override
  String get homeB => 'タイトル';

  @override
  String get homeC => 'プロジェクト名を入力してください';

  @override
  String get homeD => '軸の設定';

  @override
  String get homeE => '軸名';

  @override
  String get homeF => '軸の名称を入力してください';

  @override
  String get homeG => '軸目盛りの最小値';

  @override
  String get homeH => '軸目盛りの最大値';

  @override
  String get alertA => '必須項目です';

  @override
  String get alertB => '目盛りの設定に不備があります';

  @override
  String get alertC => '入力に不備があります';

  @override
  String get alertD => 'CSVデータが読み込まれていません';

  @override
  String get alertE => '数値を入力してください';

  @override
  String get alertF => '最小値より大きな値';

  @override
  String get topA => '保存されたプロジェクトはありません';

  @override
  String get topB => '削除しますか？';

  @override
  String get topC => '削除後は復元できません';

  @override
  String get saveA => '保存しますか？';

  @override
  String get saveB => '保存後は変更できません';

  @override
  String get saveC => 'CSVファイルを選択してください';

  @override
  String get saveD => '保存';

  @override
  String get fileA => '読み込みが完了しました';

  @override
  String get fileB => '選択がキャンセルされました';

  @override
  String get fileC => '読み込みに失敗しました';

  @override
  String get permissionA => 'ファイルを開くためにドキュメントフォルダへのアクセスが必要です。';

  @override
  String get permissionB => 'この機能を使うためにファイルのアクセスを許可してください。';

  @override
  String get permissionC => '設定を開く';

  @override
  String get infoA => '個人情報等の扱いについて';

  @override
  String get infoB => 'このアプリは、あなたのどんな個人情報も一切取得しませんし、あなたのデバイス内の情報を追跡、利用することもありません。';

  @override
  String get infoC => 'あなたのデバイス内にあるCSVデータを用いて三次元散布図を作成し、あなたのデバイス内に保存します。';

  @override
  String get infoD => '広告';

  @override
  String get infoE => 'このアプリには広告を掲載しておりません。したがって、広告から動作を追跡されることもありません。安心してご利用いただくと同時に、買取制にご理解をいただきますようお願い申し上げます。';

  @override
  String get infoF => 'お問い合わせ';

  @override
  String get infoG => 'ご不明の点は下記へお問い合わせください。';

  @override
  String get infoH => 'ecole.la.porte@gmail.com';
}
