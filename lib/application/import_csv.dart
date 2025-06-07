import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:scatter3d_maker/widget/snackbar.dart';
import 'package:csv/csv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CsvImporter {
  Future<({List<Map<String, dynamic>> parsedData, String? filePath})> importCSV(BuildContext context) async {
    // Pick a CSV file using file_picker
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null && result.files.single.path != null) {
      final File file = File(result.files.single.path!);
      final String csvString = await file.readAsString();

      // Parse CSV data using csv package
      List<List<dynamic>> rows = const CsvToListConverter().convert(csvString);

      // Assume the first row contains the header and skip it
      List<Map<String, dynamic>> parsedData = [];
      for (var i = 1; i < rows.length; i++) {
        var row = rows[i];
        parsedData.add({
          'id': row[0].toString(),
          'x': (row[1] as num).toDouble(),
          'y': (row[2] as num).toDouble(),
          'z': (row[3] as num).toDouble(),
          'color': row[4].toString(),
          'size': row[5] is int ? row[5] : (row[5] as num).toInt(),
        });
      }

      SuccessSnackBar.show(AppLocalizations.of(context)!.fileA);
      return (parsedData: parsedData, filePath: result.files.single.path);
    } else {
      // Handle cancellation or error in file picking
      FailureSnackBar.show(AppLocalizations.of(context)!.fileB);
      return (parsedData: <Map<String, dynamic>>[], filePath: null);
    }
  }

  Future<List<Map<String, dynamic>>> loadFromPath(String filePath, BuildContext context) async {
    try {
      final File file = File(filePath);
      final String csvString = await file.readAsString();

      // Parse CSV data using csv package
      List<List<dynamic>> rows = const CsvToListConverter().convert(csvString);

      // Assume the first row contains the header and skip it
      List<Map<String, dynamic>> parsedData = [];
      for (var i = 1; i < rows.length; i++) {
        var row = rows[i];
        parsedData.add({
          'id': row[0].toString(),
          'x': (row[1] as num).toDouble(),
          'y': (row[2] as num).toDouble(),
          'z': (row[3] as num).toDouble(),
          'color': row[4].toString(),
          'size': row[5] is int ? row[5] : (row[5] as num).toInt(),
        });
      }
      return parsedData;
    } catch (e) {
      FailureSnackBar.show(AppLocalizations.of(context)!.fileC);
      return [];
    }
  }
}