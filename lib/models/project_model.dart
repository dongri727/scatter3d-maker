class ProjectModel {
  int? key;
  String projectName;
  String xLegend;
  double xMax;
  double xMin;
  String yLegend;
  double yMax;
  double yMin;
  String zLegend;
  double zMax;
  double zMin;
  String? csvFilePath;
  List<Map<String, dynamic>> jsonData;
  bool isSaved;
  final DateTime createdAt;

  ProjectModel({
    this.key,
    required this.projectName,
    required this.xLegend,
    required this.xMax,
    required this.xMin,
    required this.yLegend,
    required this.yMax,
    required this.yMin,
    required this.zLegend,
    required this.zMax,
    required this.zMin,
    this.csvFilePath,
    required this.jsonData,
    required this.isSaved,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'projectName': projectName,
      'xLegend': xLegend,
      'xMax': xMax,
      'xMin': xMin,
      'yLegend': yLegend,
      'yMax': yMax,
      'yMin': yMin,
      'zLegend': zLegend,
      'zMax': zMax,
      'zMin': zMin,
      'csvFilePath': csvFilePath,
      'jsonData': jsonData,
      'isSaved': isSaved,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  ProjectModel copyWith({
    int? key,
    String? projectName,
    String? xLegend,
    double? xMax,
    double? xMin,
    String? yLegend,
    double? yMax,
    double? yMin,
    String? zLegend,
    double? zMax,
    double? zMin,
    String? csvFilePath,
    List<Map<String, dynamic>>? jsonData,
    bool? isSaved,
    DateTime? createdAt,
  }) {
    return ProjectModel(
      key: key ?? this.key,
      projectName: projectName ?? this.projectName,
      xLegend: xLegend ?? this.xLegend,
      xMax: xMax ?? this.xMax,
      xMin: xMin ?? this.xMin,
      yLegend: yLegend ?? this.yLegend,
      yMax: yMax ?? this.yMax,
      yMin: yMin ?? this.yMin,
      zLegend: zLegend ?? this.zLegend,
      zMax: zMax ?? this.zMax,
      zMin: zMin ?? this.zMin,
      csvFilePath: csvFilePath ?? this.csvFilePath,
      jsonData: jsonData ?? this.jsonData,
      isSaved: isSaved ?? this.isSaved,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static ProjectModel fromMap(int key, Map<String, dynamic> map) {
    final jsonDataRaw = map['jsonData'] as List<dynamic>;
    final jsonData = jsonDataRaw.map((item) {
      return Map<String, dynamic>.from(item as Map<dynamic, dynamic>);
    }).toList();

    return ProjectModel(
      key: key,
      projectName: map['projectName'] as String,
      xLegend: map['xLegend'] as String,
      xMax: map['xMax'] as double,
      xMin: map['xMin'] as double,
      yLegend: map['yLegend'] as String,
      yMax: map['yMax'] as double,
      yMin: map['yMin'] as double,
      zLegend: map['zLegend'] as String,
      zMax: map['zMax'] as double,
      zMin: map['zMin'] as double,
      csvFilePath: map['csvFilePath'] as String?,
      jsonData: jsonData,
      isSaved: map['isSaved'] as bool,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}