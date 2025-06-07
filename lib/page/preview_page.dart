import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';
import '../models/project_model.dart';
import '../widget/scatter_plot_widget.dart';
import '../widget/snackbar.dart';
import '../application/import_csv.dart';

class PreviewPage extends StatefulWidget {
  final String projectKey;

  const PreviewPage({
    super.key,
    required this.projectKey,
  });

  @override
  PreviewPageState createState() => PreviewPageState();
}

class PreviewPageState extends State<PreviewPage> {
  ProjectProvider? _projectProvider;
  ProjectModel? _project;
  List<dynamic>? scores;
  final _csvImporter = CsvImporter();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _projectProvider = Provider.of<ProjectProvider>(context, listen: false);
      _projectProvider?.loadProjects();
      _loadData();
    });
  }

  Future<void> _loadData() async {
    try {
      if (_projectProvider == null) return;
      _project = await _projectProvider!.getProject(int.parse(widget.projectKey));
      
      if (_project == null || _project!.csvFilePath == null) {
        FailureSnackBar.show('Project or CSV path not found');
        return;
      }

      // Use stored JSON if available, otherwise fall back to reloading the CSV file
      final List<Map<String, dynamic>> parsedData = _project!.jsonData != null
          ? List<Map<String, dynamic>>.from(_project!.jsonData)
          : await _csvImporter.loadFromPath(_project!.csvFilePath!, context);
      
      final List<dynamic> transformed = parsedData.map((data) {
        return {
          'value': [
            data['x'].toDouble(),
            data['y'].toDouble(),
            data['z'].toDouble(),
          ],
          'name': data['id'].toString(),
          'itemStyle': {'color': data['color'].toString()},
          'symbolSize': data['size'] is int ? data['size'] : (data['size'] as num).toInt(),
        };
      }).toList();

      if (!mounted) return;
      setState(() {
        scores = transformed;
      });
    } catch (e) {
      if (!mounted) return;
      FailureSnackBar.show(e.toString());
      Navigator.popUntil(context, ModalRoute.withName('/topPage'));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_project == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final scatterData = ScatterPlotData(
      title: _project!.projectName,
      xAxis: AxisData(
        legend: _project!.xLegend,
        min: _project!.xMin,
        max: _project!.xMax,
      ),
      yAxis: AxisData(
        legend: _project!.yLegend,
        min: _project!.yMin,
        max: _project!.yMax,
      ),
      zAxis: AxisData(
        legend: _project!.zLegend,
        min: _project!.zMin,
        max: _project!.zMax,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 6,
        shadowColor: Colors.blueGrey[50],
        shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(8))),
        title: const Text('Your Project'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(_project!.projectName),
            ),
            ScatterPlotWidget(
              scatterData: scatterData,
              scores: scores,
            ),
          ],
        ),
      ),
    );
  }
}

class AxisData {
  final String legend;
  final double min;
  final double max;

  AxisData({
    required this.legend,
    required this.min,
    required this.max,
  });
}

class ScatterPlotData {
  final String title;
  final AxisData xAxis;
  final AxisData yAxis;
  final AxisData zAxis;

  ScatterPlotData({
    required this.title,
    required this.xAxis,
    required this.yAxis,
    required this.zAxis,
  });
}