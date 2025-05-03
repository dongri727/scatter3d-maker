import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:scatter3d_maker/models/project_model.dart';
import 'package:scatter3d_maker/providers/project_provider.dart';
import '../widget/snackbar.dart';
import '../widget/scatter_plot_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../constants/strings.dart';
import '../widget/dialog.dart';

class SecondPage extends StatefulWidget {
  final dynamic scatterData;
  final dynamic parsedData;

  const SecondPage({
    super.key, 
    required this.scatterData, 
    required this.parsedData,
  });

  @override
  SecondPageState createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late ProjectProvider _projectProvider;

  List<dynamic>? scores;

  @override
  void initState() {
    super.initState();
    _loadData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _projectProvider.loadProjects();
    });
  }

  Future<void> _loadData() async {
    // widget.parsedData は List<Map<String,dynamic>> として渡されている前提
    final List<dynamic> transformed = (widget.parsedData as List<Map<String, dynamic>>)
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

  Future<void> _saveData() async {

    showAlertDialog(
      context: context,
      title: '保存しますか？',
      content: '一度保存したプロジェクトは、設定の変更ができません',
      confirmText: 'OK',
      onConfirm: () async {
        try {
          _projectProvider = Provider.of<ProjectProvider>(context, listen: false);
          final newProject = ProjectModel(
            projectName: widget.scatterData.title,
            xLegend: widget.scatterData.xAxis.legend,
            xMax: widget.scatterData.xAxis.max,
            xMin: widget.scatterData.xAxis.min,
            yLegend: widget.scatterData.yAxis.legend,
            yMax: widget.scatterData.yAxis.max,
            yMin: widget.scatterData.yAxis.min,
            zLegend: widget.scatterData.zAxis.legend,
            zMax: widget.scatterData.zAxis.max,
            zMin: widget.scatterData.zAxis.min,
            csvFilePath: '',
            jsonData: widget.parsedData,
            isSaved: true,
            createdAt: DateTime.now(),
          );
          await _projectProvider.addProject(newProject);
          if (!mounted) return; 
          Navigator.popUntil(context, ModalRoute.withName('/topPage'));
        }
        catch (e) {
          FailureSnackBar.show(e.toString());
        }
      },
      onCancel: () {
        return;
      },
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Scatter 3D"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.scatterData.title),
            ScatterPlotWidget(
              scatterData: widget.scatterData,
              scores: scores,
            ),
            ElevatedButton.icon(
              onPressed: () {
                _saveData();
              }, 
              icon: const Icon(Icons.save),
              label: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}