import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';
import '../models/project_model.dart';
import '../widget/scatter_plot_widget.dart';
import '../widget/snackbar.dart';

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
      SuccessSnackBar.show('Project loaded');
      if (_project == null) return;

      final List<dynamic> transformed = (_project!.jsonData as List<dynamic>)
          .map((dynamic item) {
            final Map<String, dynamic> data = Map<String, dynamic>.from(item as Map<dynamic, dynamic>);
            return {
              'value': [
                (data['x'] as num).toDouble(),
                (data['y'] as num).toDouble(),
                (data['z'] as num).toDouble(),
              ],
              'name': data['id'].toString(),
              'itemStyle': {'color': data['color'].toString()},
              'symbolSize': data['size'] is int ? data['size'] : (data['size'] as num).toInt(),
            };
          })
          .toList();

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
        title: const Text('Scatter 3D'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(_project!.projectName),
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