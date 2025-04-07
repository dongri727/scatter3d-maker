import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '../gl_script.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  SecondPageState createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
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
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Scores'),
      ),
      body: Center(
        child: SizedBox(
          width: 800,
          height: 800,
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
          min: 0,
          max: 100,
          splitLine: {show: false},
          name: '数学',
        },
        yAxis3D: {
          type: 'value',
          min: 0,
          max: 100,
          splitLine: {show: false},                  
          name: '英語',
        },
        zAxis3D: {
          type: 'value',
          min: 0,
          max: 100,
          splitLine: {show: false},
          name: '国語',                               
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
      ),
    );
  }
}