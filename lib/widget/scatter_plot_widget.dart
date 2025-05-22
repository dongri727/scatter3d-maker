import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '../gl_script.dart';

class ScatterPlotWidget extends StatelessWidget {
  final dynamic scatterData;
  final List<dynamic>? scores;

  const ScatterPlotWidget({
    super.key,
    required this.scatterData,
    required this.scores,
  });

  @override
  Widget build(BuildContext context) {
    final shortest = MediaQuery.of(context).size.shortestSide;
    final displaySize = shortest < 500.0 ? shortest : 500.0;
    return SizedBox(
      width: displaySize,
      height: displaySize,
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
      min: ${scatterData.xAxis.min},
      max: ${scatterData.xAxis.max},
      name: '${scatterData.xAxis.legend}',
    },
    yAxis3D: {
      type: 'value',
      min: ${scatterData.yAxis.min},
      max: ${scatterData.yAxis.max},
      name: '${scatterData.yAxis.legend}',
    },
    zAxis3D: {
      type: 'value',
      min: ${scatterData.zAxis.min},
      max: ${scatterData.zAxis.max},
      name: '${scatterData.zAxis.legend}',                         
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
    );
  }
} 