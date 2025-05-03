import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';
import '../models/project_model.dart';
import '../widget/scatter_plot_widget.dart';

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
  late ProjectProvider _projectProvider;
  late ProjectModel? _project;

  List<dynamic>? scores;

  @override
  void initState() {
    super.initState();
    _projectProvider = Provider.of<ProjectProvider>(context, listen: false);
    _projectProvider.loadProjects();
    _loadData();
  }

  Future<void> _loadData() async {
    // widget.parsedData は List<Map<String,dynamic>> として渡されている前提
    _project = await _projectProvider.getProject(int.parse(widget.projectKey));

    final List<dynamic> transformed = (_project!.jsonData as List<Map<String, dynamic>>)
        .map((item) => {
      'value': [item['x'], item['y'], item['z']],
      'name': item['id'],
      'itemStyle': {'color': item['color']},
      'symbolSize': item['size'], // sizeでドットの大きさを個別指定
    })
        .toList();

    setState(() {
      scores = transformed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scatter 3D'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(_project!.projectName),
            ScatterPlotWidget(
              scatterData: _project!.jsonData,
              scores: scores,
            ),
          ],
        ),
      ),
    );
  }
}