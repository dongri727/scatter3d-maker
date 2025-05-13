import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'hint_csv_config.dart';
import 'hint_project_config.dart';
import 'hint_scatter.dart';

class HintTab extends StatelessWidget {
  const HintTab ({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'What is Scatter 3D ?',
          ),
          bottom: const TabBar(
            indicatorColor: Colors.yellow,
            tabs: [
              Tab(text: "表示例"),
              Tab(text: "設定方法"),
              Tab(text: "データ形式"),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            HintScatterPage(),
            HintProjectConfig(),
            HintCsvConfig()
          ],
        ),
      ),
    );
  }
}