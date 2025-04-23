import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '../gl_script.dart';

class SecondPage extends StatefulWidget {
  final dynamic scatterData;
  final dynamic parsedData;


  const SecondPage(this.scatterData, this.parsedData, {super.key});

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
    // widget.parsedData は List<Map<String,dynamic>> として渡されている前提
    final List<dynamic> transformed = (widget.parsedData as List<Map<String, dynamic>>)
        .map((item) => {
      'value': [item['x'], item['y'], item['z']],
      'name': item['id'],
      'itemStyle': {'color': item['color']},
      'symbolSize': item['size'], // sizeでドットの大きさを個別指定
    })
        .toList();

    setState(() {
      scores = transformed;
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