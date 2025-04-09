import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:scatter3d_maker/widget/snackbar.dart';
import '../widget/line_chart_widget.dart';

class ImportCsv extends StatefulWidget {
  @override
  State<ImportCsv> createState() => _ImportCsvState();

}

class _ImportCsvState extends State<ImportCsv> {
  List<FlSpot> _dataPoints = [];

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pickAndLoadCsv(); // 画面がビルドされたあとに実行
    });
  }

  Future<void> _pickAndLoadCsv() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      String content = await file.readAsString();
      _parseCsv(content);
    } else {
      Navigator.pop(context);
      FailureSnackBar.show('ファイルの選択がキャンセルされました');
    }
  }

  void _parseCsv(String content) {
    List<FlSpot> tempData = [];
    List<String> lines = content.split('\n');

    for (int i = 1; i < lines.length; i++) {
      String line = lines[i].trim();
      if (line.isEmpty) continue;

      List<String> parts = line.split(',');
      if (parts.length < 2) continue;

      try {
        int no = int.parse(parts[0].trim());
        double speedCm = double.parse(parts[1].trim());
        double speed = speedCm / 100.0;
        double timeInSeconds = (no * 5) / 1000.0;
        tempData.add(FlSpot(timeInSeconds, speed));
      } catch (e) {
        continue;
      }
    }

    setState(() {
      _dataPoints = tempData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSVグラフ表示'),
      ),
      body: Column(
        children: [
          Expanded(
            child: LineChartWidget(dataPoints: _dataPoints),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}