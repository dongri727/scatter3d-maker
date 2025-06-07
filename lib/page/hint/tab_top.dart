import 'package:flutter/material.dart';
import 'hint_csv_config.dart';
import 'hint_project_config.dart';
import 'hint_scatter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HintTab extends StatelessWidget {
  const HintTab ({super.key});

  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'What is Scatter 3D ?',
          ),
          bottom: TabBar(
            indicatorColor: Colors.lime,
            tabs: [
              Tab(text: AppLocalizations.of(context)!.hintA),
              Tab(text: AppLocalizations.of(context)!.hintB),
              Tab(text: AppLocalizations.of(context)!.hintC),
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