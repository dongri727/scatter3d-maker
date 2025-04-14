import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '../gl_script.dart';

class SecondPage extends StatefulWidget {
  final dynamic scatterData;

  const SecondPage(this.scatterData, {super.key});

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
        title: const Text("Scatter 3D"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.scatterData.title),
            SizedBox(
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
          min: ${widget.scatterData.xAxis.min},
          max: ${widget.scatterData.xAxis.max},
          name: '${widget.scatterData.xAxis.legend}',
        },
        yAxis3D: {
          type: 'value',
          min: ${widget.scatterData.yAxis.min},
          max: ${widget.scatterData.yAxis.max},
          name: '${widget.scatterData.yAxis.legend}',
        },
        zAxis3D: {
          type: 'value',
          min: ${widget.scatterData.zAxis.min},
          max: ${widget.scatterData.zAxis.max},
          name: '${widget.scatterData.zAxis.legend}',                         
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