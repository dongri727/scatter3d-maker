import 'package:sembast/sembast.dart';
import 'package:scatter3d_maker/database/sembast_database.dart';
import 'package:scatter3d_maker/models/project_model.dart';

class ProjectDao {
  static const String storeName = 'projects';
  final _store = intMapStoreFactory.store(storeName);

  Future<ProjectModel?> getProject(int key) async {
    final db = await SembastDatabase().database;
    final snapshot = await _store.record(key).get(db);
    return snapshot != null ? ProjectModel.fromMap(key, snapshot) : null;
  }

  Future<List<ProjectModel>> getAllProjects() async {
    final db = await SembastDatabase().database;
    final recordSnapshots = await _store.find(db);
    return recordSnapshots.map((snapshot) {
      final data = snapshot.value;
      return ProjectModel.fromMap(snapshot.key, data);
    }).toList();
  }

  Future<int> insertProject(ProjectModel project) async {
    final db = await SembastDatabase().database;
    return await _store.add(db, project.toMap());
  }


  Future<void> updateProject(ProjectModel project) async {
    if (project.key == null) return;
    final db = await SembastDatabase().database;
    await _store.record(project.key!).put(db, project.toMap());
  }


  Future deleteProject(int key) async {
    final db = await SembastDatabase().database;
    await _store.record(key).delete(db);
  }
}