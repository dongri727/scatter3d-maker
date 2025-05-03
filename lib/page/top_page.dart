import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../page/setting_page.dart';
import '../page/home_page.dart';
import '../page/preview_page.dart';
import 'package:provider/provider.dart';
import 'package:scatter3d_maker/providers/project_provider.dart';

class TopPage extends StatefulWidget { 
  const TopPage({super.key});

  @override
  _TopPageState createState() => _TopPageState(); 
}

class _TopPageState extends State<TopPage> { 
  late ProjectProvider _projectProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _projectProvider.loadProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProjectProvider>(context);
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
      body: _provider.projects.isEmpty
          ? const Center(child: Text('データがありません'))
          : ListView.builder(
              itemCount: _provider.projects.length,
              itemBuilder: (context, index) {
                final project = _provider.projects[index];
                return ListTile(
                  title: Text(project.projectName),
                  subtitle: Text('X: ${project.xMin} ~ ${project.xMax} | Y: ${project.yMin} ~ ${project.yMax} | Z: ${project.zMin} ~ ${project.zMax}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PreviewPage(projectKey: project.key.toString())),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}