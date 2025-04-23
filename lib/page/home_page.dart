import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scatter3d_maker/widget/snackbar.dart';
import 'second_page.dart';
import '../widget/axis_config_widget.dart';
import '../widget/text_field.dart';
import '../widget/hint_page.dart';
import '../constants/app_colors.dart';
import 'home_page_model.dart';
import '../providers/project_provider.dart';
import 'package:scatter3d_maker/models/project_model.dart';
import 'package:scatter3d_maker/providers/project_provider.dart';
import '../database/project_dao.dart';

class MyHomePage extends StatefulWidget {
  final int projectId;
  const MyHomePage({super.key, required this.projectId});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final ProjectDao _dao = ProjectDao();
  final _projectProvider = ProjectProvider();
  bool _showValidation = false;
  List<Map<String, dynamic>>? _parsedData;
  List<Map<String, dynamic>>? scatterData;

  ProjectModel? _project;

  @override
  void initState() {
    super.initState();
    _projectProvider.loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageModel>(
      create: (_) => HomePageModel(projectId: widget.projectId),
      child: Builder(
        builder: (context) {
          final model = Provider.of<HomePageModel>(context);
          Future<void> importCSV() async {
            // Pick a CSV file using file_picker
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['csv'],
            );

            if (result != null && result.files.single.path != null) {
              final File file = File(result.files.single.path!);
              final String csvString = await file.readAsString();

              // Parse CSV data using csv package
              List<List<dynamic>> rows =
              const CsvToListConverter().convert(csvString);

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
              setState(() {
                _parsedData = parsedData;
              });

              final updatedProject = _project?.copyWith(
              xLegend: model.xLegend,
              xMax: model.xMax,
              xMin: model.xMin,
              yLegend: model.yLegend,
              yMax: model.yMax,
              yMin: model.yMin,
              zLegend: model.zLegend,
              zMax: model.zMax,
              zMin: model.zMin,
              csvFilePath: result.files.single.path!,
            );
            if (updatedProject != null) {
              await _projectProvider.updateProject(updatedProject);
            }
              SuccessSnackBar.show('CSVデータを読み込みました。');
            } else {
              // Handle cancellation or error in file picking
              FailureSnackBar.show('CSVファイルの選択がキャンセルされました。');
            }
          }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Upload your csv data"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HintPage(), fullscreenDialog: true),
              );
            }, 
            icon: const Icon(Icons.question_mark))
        ],
      ),
            body: Center(
              child: FutureBuilder<ProjectModel?>(
                future: _dao.getProject(widget.projectId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('エラーが発生しました: ${snapshot.error}');
                  }

                  _project = snapshot.data;
                  
                  return Form(
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
                            label: 'タイトル',
                            hintText: '散布図のタイトル名を入力してください',
                            initialValue: model.scatterTitle,
                            onChanged: model.setScatterTitle,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '必須項目です';
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
                                    importCSV();

                                } else {
                                  FailureSnackBar.show(
                                      '最大値最小値の設定に不備があります。設定内容をご確認ください。');
                                }
                              } else {
                                FailureSnackBar.show(
                                    '入力内容に不備があります。エラーメッセージをご確認ください。');
                              }
                            },
                            icon: const Icon(Icons.file_upload),
                            label: const Text('Import CSV'),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  );
                },
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
                      builder: (context) => SecondPage(scatterData, _parsedData!),
                    ),
                  );
                } else {
                  FailureSnackBar.show('CSVデータが読み込まれていません。');
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