import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  final List<FlSpot> dataPoints;

  const LineChartWidget({
    super.key,
    required this.dataPoints,
  });

  @override
  Widget build(BuildContext context) {
    if (dataPoints.isEmpty) {
      return const Center(child: Text('CSVファイルを読み込んでください。'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: _calculateXInterval(),
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('${value.toStringAsFixed(2)}'),
                  );
                },
              ),
              axisNameWidget: const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text('[s]'),
              ),
              axisNameSize: 20,
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: _calculateYInterval(),
                getTitlesWidget: (value, meta) {
                  return Text('${value.toStringAsFixed(1)}');
                },
              ),
              axisNameWidget: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text('[m/min]'),
              ),
              axisNameSize: 20,
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.black, width: 1),
          ),
          minX: dataPoints.first.x,
          maxX: dataPoints.last.x,
          minY: _getMinY(),
          maxY: _getMaxY(),
          lineBarsData: [
            LineChartBarData(
              spots: dataPoints,
              isCurved: false,
              color: Colors.blue,
              barWidth: 2,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  double _getMinY() {
    double minY = dataPoints.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    return minY - 1;
  }

  double _getMaxY() {
    double maxY = dataPoints.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    return maxY + 1;
  }

  double _calculateXInterval() {
    double totalTime = dataPoints.last.x - dataPoints.first.x;
    return totalTime / 5;
  }

  double _calculateYInterval() {
    double maxY = _getMaxY();
    return (maxY / 5).ceilToDouble();
  }
} 