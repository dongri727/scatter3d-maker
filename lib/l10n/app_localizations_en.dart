// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hintA => 'Example View';

  @override
  String get hintB => 'How to Set';

  @override
  String get hintC => 'Data Format';

  @override
  String get hintD => 'Your CSV data will be visualized like this';

  @override
  String get hintE => 'On the input screen';

  @override
  String get hintF => 'assets/images/en.jpg';

  @override
  String get hintG => 'Axis Settings';

  @override
  String get hintH => '① Item name: Label for the axis\n\n② Maximum value: Maximum scale value\n(Should be larger than the data maximum)\n\n③ Minimum value: Minimum scale value. Can be negative\n(Should be smaller than the data minimum)\n\n* All required * Max > Min';

  @override
  String get hintI => 'Export data created with Excel or Numbers as a CSV file.\n\nid is the label for each data point, can be a number or a name.\n\nx, y, z are coordinates of the data,\nCan be integers or decimals, positive or negative.\n\nColor should be a simple English color name,\nSingle color is okay.\n\nSize should be one of 10, 20, or 30. Uniform size is also acceptable.\nThe smallest dot in the sample image is 10.';

  @override
  String get homeA => 'Chart Setting';

  @override
  String get homeB => 'Chart Title';

  @override
  String get homeC => 'Chart Title';

  @override
  String get homeD => '-Axis';

  @override
  String get homeE => '-axis Label';

  @override
  String get homeF => '-axis Label';

  @override
  String get homeG => '-scale Minimum';

  @override
  String get homeH => '-scale Maximum';

  @override
  String get alertA => 'Required';

  @override
  String get alertB => 'The scale setting is incorrect';

  @override
  String get alertC => 'Incomplete entry';

  @override
  String get alertD => 'CSV-data not loaded';

  @override
  String get alertE => 'enter a value';

  @override
  String get alertF => 'greater than min';

  @override
  String get topA => 'No saved projects';

  @override
  String get topB => 'Are you sure you want to delete?';

  @override
  String get topC => 'This action cannot be undone';

  @override
  String get saveA => 'Do you want to save?';

  @override
  String get saveB => 'This cannot be changed after saving';

  @override
  String get saveC => 'Select your CSV file';

  @override
  String get saveD => 'Save';

  @override
  String get fileA => 'Loading complete';

  @override
  String get fileB => 'Selection canceled';

  @override
  String get fileC => 'Loading failed';

  @override
  String get permissionA => 'This app needs access to your documents folder to open files.';

  @override
  String get permissionB => 'This feature requires access to your files.';

  @override
  String get permissionC => 'Open Settings';

  @override
  String get infoA => 'Handling of Personal Information';

  @override
  String get infoB => 'This app does not collect any personal information from you, nor does it track or use any information on your device.';

  @override
  String get infoC => 'Create a three-dimensional scatterplot using the CSV data in your device and store it in your device.';

  @override
  String get infoD => 'Advertisements';

  @override
  String get infoE => 'This app does not display any advertisements. Therefore, there is no tracking from ads. We hope you enjoy using the app with peace of mind and appreciate your understanding of the purchase-based model.';

  @override
  String get infoF => 'Contact Us';

  @override
  String get infoG => 'If you have any questions, please contact us at the email address below.';

  @override
  String get infoH => 'ecole.la.porte@gmail.com';
}
