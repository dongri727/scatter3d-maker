import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scatter3d_maker/widget/snackbar.dart';
import 'hint/tab_top.dart';
import 'second_page.dart';
import '../widget/axis_config_widget.dart';
import '../widget/text_field.dart';
import '../widget/hint_page.dart';
import '../constants/app_colors.dart';
import 'home_page_model.dart';
import '../application/import_csv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widget/permission_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  bool _showValidation = false;
  List<Map<String, dynamic>>? _parsedData;
  List<Map<String, dynamic>>? scatterData;
  String? _csvFilePath;
  final _csvImporter = CsvImporter();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageModel>(
      create: (_) => HomePageModel(),
      child: Builder(
        builder: (context) {
          final model = Provider.of<HomePageModel>(context);

          
          Future<void> handleImportCSV() async {
            final result = await _csvImporter.importCSV(context);
            if (result.parsedData.isNotEmpty) {

              setState(() {
                _parsedData = result.parsedData;
                _csvFilePath = result.filePath;
              });
            }
          }

          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(AppLocalizations.of(context)!.homeA),
              actions: [
                IconButton(

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HintTab(),
                            fullscreenDialog: true),
                      );
                    },
                    icon: const Icon(Icons.question_mark))

              ],
            ),
            body: Center(
              child: Form(
                key: _formKey,
                autovalidateMode: _showValidation
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MyTextField(
                        label: AppLocalizations.of(context)!.homeB,
                        hintText: AppLocalizations.of(context)!.homeC,
                        onChanged: (value) {
                          model.setScatterTitle(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.alertA;
                          }
                          return null;
                        },
                      ),
                      AxisConfigWidget(
                        axisLabel: 'x',
                        legend: model.xLegend,
                        minVal: model.xMin,
                        maxVal: model.xMax,
                        onLegendChanged: (value) => model.setXLegend(value),
                        onMinValChanged: (value) => model.setXMin(value),
                        onMaxValChanged: (value) => model.setXMax(value),
                      ),
                      AxisConfigWidget(
                        axisLabel: 'y',
                        legend: model.yLegend,
                        minVal: model.yMin,
                        maxVal: model.yMax,
                        onLegendChanged: (value) => model.setYLegend(value),
                        onMinValChanged: (value) => model.setYMin(value),
                        onMaxValChanged: (value) => model.setYMax(value),
                      ),
                      AxisConfigWidget(
                        axisLabel: 'z',
                        legend: model.zLegend,
                        minVal: model.zMin,
                        maxVal: model.zMax,
                        onLegendChanged: (value) => model.setZLegend(value),
                        onMinValChanged: (value) => model.setZMin(value),
                        onMaxValChanged: (value) => model.setZMax(value),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _showValidation = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            if (model.xMax > model.xMin &&
                                model.yMax > model.yMin &&
                                model.zMax > model.zMin) {
                              handleImportCSV();

                            } else {
                              FailureSnackBar.show(
                                  AppLocalizations.of(context)!.alertB);
                            }
                          } else {
                            FailureSnackBar.show(
                                AppLocalizations.of(context)!.alertC);
                          }
                        },
                        icon: const Icon(Icons.file_upload),
                        label: const Text('Import CSV'),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Providerから集約済みのscatterDataを取得してSecondPageへ
                final scatterData = model.scatterPlotData;
                if (_parsedData != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (context) => SecondPage(
                        scatterData: scatterData,
                        parsedData: _parsedData!,
                        csvFilePath: _csvFilePath,
                      ),

                    ),
                  );
                } else {
                  FailureSnackBar.show(AppLocalizations.of(context)!.alertD);
                }
              },
              child: const Icon(Icons.last_page),
            ),
          );
        },
      ),
    );
  }
}
