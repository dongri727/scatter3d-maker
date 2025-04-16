import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../page/setting_page.dart';
import '../page/home_page.dart';
import '../widget/dialog_text.dart';

class TopPage extends StatefulWidget { 
  const TopPage({super.key});

  @override
  _TopPageState createState() => _TopPageState(); 
}

class _TopPageState extends State<TopPage> { 
  final List<String> _projects = [
    "test1",
    "test2",
    "test3",
  ];

  Future<void> _addNewProject() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => const DialogText(
        title: "新規プロジェクト",
        text: "",
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        _projects.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_projects[index]),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewProject,
        child: const Icon(Icons.add),
      ),
    );
  }
}