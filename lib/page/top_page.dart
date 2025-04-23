import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../page/setting_page.dart';
import '../page/home_page.dart';
import '../widget/dialog_text.dart';
import 'package:provider/provider.dart';
import 'package:scatter3d_maker/models/project_model.dart';
import 'package:scatter3d_maker/providers/project_provider.dart';
import 'package:logging/logging.dart';
import 'package:scatter3d_maker/utils/log_control.dart';

Logger log = Logger('TopPage.class');

class TopPage extends StatefulWidget { 
  const TopPage({super.key});

  @override
  _TopPageState createState() => _TopPageState(); 
}

class _TopPageState extends State<TopPage> { 
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProjectProvider>(context, listen: false).loadProjects();
    });
    log.info('TopPage initState');
  }

  Future<void> _addNewProject() async {
    final provider = Provider.of<ProjectProvider>(context, listen: false);
    final newProject = ProjectModel(

      projectName: "",
      xLegend: "",
      xMax: 0.0,
      xMin: 0.0,
      yLegend: "",
      yMax: 0.0,
      yMin: 0.0,
      zLegend: "",
      zMax: 0.0,
      zMin: 0.0,
      csvFilePath: "",
      jsonData: "",
      scatterImagePath: "",
      createdAt: DateTime.now(),
    );

    final result = await showDialog<String>(
      context: context,
      builder: (context) => const DialogText(
        title: "新規プロジェクト",
        text: "",
      ),
    );

    if (result != null && result.isNotEmpty) {
      newProject.projectName = result;
      final key = await provider.addProject(newProject);
      newProject.key = key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProjectProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Image.asset("assets/images/scatter3d-maker.png"),
        title: const Text("Scatter3D Maker"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingPage(
                    onLanguageChanged: (String language) {
                      // TODO: Implement language change logic
                    },
                  ),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),  
      body: provider.projects.isEmpty
          ? const Center(child: Text('データがありません'))
          : ListView.builder(
              itemCount: provider.projects.length,
              itemBuilder: (context, index) {
                final project = provider.projects[index];
                return ListTile(
                  title: Text(project.projectName),
                  subtitle: Text('X: ${project.xMin} ~ ${project.xMax} | Y: ${project.yMin} ~ ${project.yMax} | Z: ${project.zMin} ~ ${project.zMax}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage(projectId: project.key!)),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          log.info('Add Button Pressed');
          _addNewProject();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}