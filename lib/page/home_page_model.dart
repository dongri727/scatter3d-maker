import 'package:flutter/material.dart';

class AxisData {
  final String legend;
  final double min;
  final double max;

  AxisData({
    required this.legend,
    required this.min,
    required this.max,
  });
}

class ScatterPlotData {
  final String title;
  final AxisData xAxis;
  final AxisData yAxis;
  final AxisData zAxis;

  ScatterPlotData({
    required this.title,
    required this.xAxis,
    required this.yAxis,
    required this.zAxis,
  });
}

class HomePageModel extends ChangeNotifier {
  String _scatterTitle = '';
  String _xLegend = '';
  double _xMin = 0.0;
  double _xMax = 0.0;
  String _yLegend = '';
  double _yMin = 0.0;
  double _yMax = 0.0;
  String _zLegend = '';
  double _zMin = 0.0;
  double _zMax = 0.0;

  // Getters
  String get scatterTitle => _scatterTitle;
  String get xLegend => _xLegend;
  double get xMin => _xMin;
  double get xMax => _xMax;
  String get yLegend => _yLegend;
  double get yMin => _yMin;
  double get yMax => _yMax;
  String get zLegend => _zLegend;
  double get zMin => _zMin;
  double get zMax => _zMax;

  // Setters（変更時にnotifyListeners()を呼び出してUIへ通知）
  void setScatterTitle(String value) {
    _scatterTitle = value;
    notifyListeners();
  }

  void setXLegend(String value) {
    _xLegend = value;
    notifyListeners();
  }

  void setXMin(double value) {
    _xMin = value;
    notifyListeners();
  }

  void setXMax(double value) {
    _xMax = value;
    notifyListeners();
  }

  void setYLegend(String value) {
    _yLegend = value;
    notifyListeners();
  }

  void setYMin(double value) {
    _yMin = value;
    notifyListeners();
  }

  void setYMax(double value) {
    _yMax = value;
    notifyListeners();
  }

  void setZLegend(String value) {
    _zLegend = value;
    notifyListeners();
  }

  void setZMin(double value) {
    _zMin = value;
    notifyListeners();
  }

  void setZMax(double value) {
    _zMax = value;
    notifyListeners();
  }

  // 集約済みのScatterPlotDataを返すゲッター
  ScatterPlotData get scatterPlotData {
    return ScatterPlotData(
      title: _scatterTitle,
      xAxis: AxisData(legend: _xLegend, min: _xMin, max: _xMax),
      yAxis: AxisData(legend: _yLegend, min: _yMin, max: _yMax),
      zAxis: AxisData(legend: _zLegend, min: _zMin, max: _zMax),
    );
  }
}