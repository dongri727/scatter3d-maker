import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

import '../../constants/app_colors.dart';
import '../../gl_script.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HintScatterPage extends StatefulWidget {
  const HintScatterPage({super.key});

  @override
  HintScatterPageState createState() => HintScatterPageState();
}

class HintScatterPageState extends State<HintScatterPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<dynamic>? scores;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final String jsonString = await rootBundle.loadString('assets/json/jhigh.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      scores = jsonData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      key: scaffoldKey,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(AppLocalizations.of(context)!.hintD),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                  height: 60,
                  "assets/images/rotate.jpg"),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: scores == null
                  ? const CircularProgressIndicator()
                  : Echarts(
                extensions: const [glScript],
                option: '''
    (function() {
      return {
        tooltip: {},
        grid3D: {
          viewControl: {
            alpha: 40,
            beta: -60,
            projection: 'orthographic'
          }
        },
        xAxis3D: {
          type: 'value',
          min: ${-5},
          max: ${110},
          name: '${"X"}',
        },
        yAxis3D: {
          type: 'value',
          min: ${-5},
          max: ${110},
          name: '${"Y"}',
        },
        zAxis3D: {
          type: 'value',
          min: ${-5},
          max: ${110},
          name: '${"Z"}',                         
        },
        series: [
          {
            type: 'scatter3D',
            symbolSize: 5,
            data: ${json.encode(scores)},
                label: {
                  show: true,
                  textStyle: {
                    fontSize: 12,
                    borderWidth: 1
                  },
                  formatter: function(param) {
                    return param.data.name;
                  }
                },
                itemStyle: {opacity: 0.8}    
              },   
            ]
                  };
              })()
              ''',
              ),
            ),

          ],
        ),
      ),
    );
  }
}