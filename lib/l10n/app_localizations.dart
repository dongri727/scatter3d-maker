import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja')
  ];

  /// No description provided for @hintA.
  ///
  /// In en, this message translates to:
  /// **'Example View'**
  String get hintA;

  /// No description provided for @hintB.
  ///
  /// In en, this message translates to:
  /// **'How to Set'**
  String get hintB;

  /// No description provided for @hintC.
  ///
  /// In en, this message translates to:
  /// **'Data Format'**
  String get hintC;

  /// No description provided for @hintD.
  ///
  /// In en, this message translates to:
  /// **'Your CSV data will be visualized like this'**
  String get hintD;

  /// No description provided for @hintE.
  ///
  /// In en, this message translates to:
  /// **'On the input screen'**
  String get hintE;

  /// No description provided for @hintF.
  ///
  /// In en, this message translates to:
  /// **'assets/images/en.jpg'**
  String get hintF;

  /// No description provided for @hintG.
  ///
  /// In en, this message translates to:
  /// **'Axis Settings'**
  String get hintG;

  /// No description provided for @hintH.
  ///
  /// In en, this message translates to:
  /// **'① Item name: Label for the axis\n\n② Maximum value: Maximum scale value\n(Should be larger than the data maximum)\n\n③ Minimum value: Minimum scale value. Can be negative\n(Should be smaller than the data minimum)\n\n* All required * Max > Min'**
  String get hintH;

  /// No description provided for @hintI.
  ///
  /// In en, this message translates to:
  /// **'Export data created with Excel or Numbers as a CSV file.\n\nid is the label for each data point, can be a number or a name.\n\nx, y, z are coordinates of the data,\nCan be integers or decimals, positive or negative.\n\nColor should be a simple English color name,\nSingle color is okay.\n\nSize should be one of 10, 20, or 30. Uniform size is also acceptable.\nThe smallest dot in the sample image is 10.'**
  String get hintI;

  /// No description provided for @homeA.
  ///
  /// In en, this message translates to:
  /// **'Chart Setting'**
  String get homeA;

  /// No description provided for @homeB.
  ///
  /// In en, this message translates to:
  /// **'Chart Title'**
  String get homeB;

  /// No description provided for @homeC.
  ///
  /// In en, this message translates to:
  /// **'Chart Title'**
  String get homeC;

  /// No description provided for @homeD.
  ///
  /// In en, this message translates to:
  /// **'-Axis'**
  String get homeD;

  /// No description provided for @homeE.
  ///
  /// In en, this message translates to:
  /// **'-axis Label'**
  String get homeE;

  /// No description provided for @homeF.
  ///
  /// In en, this message translates to:
  /// **'-axis Label'**
  String get homeF;

  /// No description provided for @homeG.
  ///
  /// In en, this message translates to:
  /// **'-scale Minimum'**
  String get homeG;

  /// No description provided for @homeH.
  ///
  /// In en, this message translates to:
  /// **'-scale Maximum'**
  String get homeH;

  /// No description provided for @alertA.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get alertA;

  /// No description provided for @alertB.
  ///
  /// In en, this message translates to:
  /// **'The scale setting is incorrect'**
  String get alertB;

  /// No description provided for @alertC.
  ///
  /// In en, this message translates to:
  /// **'Incomplete entry'**
  String get alertC;

  /// No description provided for @alertD.
  ///
  /// In en, this message translates to:
  /// **'CSV-data not loaded'**
  String get alertD;

  /// No description provided for @alertE.
  ///
  /// In en, this message translates to:
  /// **'enter a value'**
  String get alertE;

  /// No description provided for @alertF.
  ///
  /// In en, this message translates to:
  /// **'greater than min'**
  String get alertF;

  /// No description provided for @topA.
  ///
  /// In en, this message translates to:
  /// **'No saved projects'**
  String get topA;

  /// No description provided for @topB.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete?'**
  String get topB;

  /// No description provided for @topC.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone'**
  String get topC;

  /// No description provided for @saveA.
  ///
  /// In en, this message translates to:
  /// **'Do you want to save?'**
  String get saveA;

  /// No description provided for @saveB.
  ///
  /// In en, this message translates to:
  /// **'This cannot be changed after saving'**
  String get saveB;

  /// No description provided for @saveC.
  ///
  /// In en, this message translates to:
  /// **'Select your CSV file'**
  String get saveC;

  /// No description provided for @saveD.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveD;

  /// No description provided for @fileA.
  ///
  /// In en, this message translates to:
  /// **'Loading complete'**
  String get fileA;

  /// No description provided for @fileB.
  ///
  /// In en, this message translates to:
  /// **'Selection canceled'**
  String get fileB;

  /// No description provided for @fileC.
  ///
  /// In en, this message translates to:
  /// **'Loading failed'**
  String get fileC;

  /// No description provided for @permissionA.
  ///
  /// In en, this message translates to:
  /// **'This app needs access to your documents folder to open files.'**
  String get permissionA;

  /// No description provided for @permissionB.
  ///
  /// In en, this message translates to:
  /// **'This feature requires access to your files.'**
  String get permissionB;

  /// No description provided for @permissionC.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get permissionC;

  /// No description provided for @infoA.
  ///
  /// In en, this message translates to:
  /// **'Handling of Personal Information'**
  String get infoA;

  /// No description provided for @infoB.
  ///
  /// In en, this message translates to:
  /// **'This app does not collect any personal information from you, nor does it track or use any information on your device.'**
  String get infoB;

  /// No description provided for @infoC.
  ///
  /// In en, this message translates to:
  /// **'Create a three-dimensional scatterplot using the CSV data in your device and store it in your device.'**
  String get infoC;

  /// No description provided for @infoD.
  ///
  /// In en, this message translates to:
  /// **'Advertisements'**
  String get infoD;

  /// No description provided for @infoE.
  ///
  /// In en, this message translates to:
  /// **'This app does not display any advertisements. Therefore, there is no tracking from ads. We hope you enjoy using the app with peace of mind and appreciate your understanding of the purchase-based model.'**
  String get infoE;

  /// No description provided for @infoF.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get infoF;

  /// No description provided for @infoG.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions, please contact us at the email address below.'**
  String get infoG;

  /// No description provided for @infoH.
  ///
  /// In en, this message translates to:
  /// **'ecole.la.porte@gmail.com'**
  String get infoH;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ja': return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
