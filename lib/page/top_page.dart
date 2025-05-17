import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/language_button.dart';
import '../page/setting_page.dart';
import '../page/home_page.dart';
import '../page/preview_page.dart';
import 'package:provider/provider.dart';
import 'package:scatter3d_maker/providers/project_provider.dart';
import 'package:scatter3d_maker/widget/dialog.dart';
import '../widget/snackbar.dart';
import 'hint/tab_top.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

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
      if (!mounted) return;
      _projectProvider = Provider.of<ProjectProvider>(context, listen: false);
      _projectProvider.loadProjects();
    });
  }

  Future<void> _deleteProject(String projectKey) async {
    final shouldDelete = await showAlertDialog(
      context: context,
      title: AppLocalizations.of(context)!.topB,
      content: AppLocalizations.of(context)!.topC,
    );

    if (shouldDelete == true) {
      await _projectProvider.deleteProject(int.parse(projectKey));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(""),
        actions: [
          const LanguageDropdownButton(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HintTab(),
                ),
              );
            },
            icon: const Icon(Icons.info_outline),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HintTab(),
                ),
              );
            },
            icon: const Icon(Icons.question_mark_sharp),
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/top.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: Column(
          children: [
            Expanded(
              flex: 1,
                child: Container()),
            Expanded(
              flex: 1,
              child: Consumer<ProjectProvider>(
                builder: (context, provider, child) {
                  return provider.projects.isEmpty
                      ? Center(child: Text(AppLocalizations.of(context)!.topA))
                      : ListView.builder(
                          itemCount: provider.projects.length,
                          itemBuilder: (context, index) {
                            final project = provider.projects[index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                              child: Card(
                                color: Colors.purple[50],
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                                  child: ListTile(
                                    leading: Text(project.projectName,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    title: Text(
                                      '${project.createdAt.year}-${project.createdAt.month}-${project.createdAt.day}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => PreviewPage(projectKey: project.key.toString())),
                                      );
                                    },
                                    trailing: IconButton(
                                      onPressed: () {
                                        _deleteProject(project.key.toString());
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
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