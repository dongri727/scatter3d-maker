import 'package:flutter/material.dart';
import 'package:scatter3d_maker/page/hint/hint_csv_config.dart';
import 'package:scatter3d_maker/page/hint/hint_project_config.dart';
import '../constants/app_colors.dart';
import '../page/hint/hint_scatter.dart';
import '../constants/strings.dart';

class HintPage extends StatefulWidget{

  const HintPage({super.key});

  @override
  State<HintPage> createState() => _HintPageState();
}

class _HintPageState extends State<HintPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("ヒントページ"),      
      ),
      body: 
      ListView(
        children: <Widget>[
          Card(
            child: 
            ListTile(
              leading: const Icon(Icons.dataset),
              title: const Text(Strings.hintScatterImages),
              trailing: const Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HintScatterPage())
                );
              },
            )
          ),
          Card(
            child: 
            ListTile(
              leading: const Icon(Icons.edit), 
              title: const Text(Strings.hintProjectConfig),
              trailing: const Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HintProjectConfig())
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.data_array),
              title: const Text(Strings.hintCsvConfig),
              trailing: const Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HintCsvConfig())
                );
              },
            ),
          ),
        ]
      )
    );
  }
}