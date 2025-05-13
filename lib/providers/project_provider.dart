import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../database/project_dao.dart';

class ProjectProvider extends ChangeNotifier {
  final ProjectDao _projectDao = ProjectDao();
  List<ProjectModel> _projects = [];  // privateに変更

  List<ProjectModel> get projects => _projects;  // getterを使用

  Future<void> loadProjects() async {
    try {
      _projects = await _projectDao.getAllProjects();
      notifyListeners();
    } catch (e) {
      throw Exception('プロジェクトの読み込みに失敗しました: $e');
    }
  }

  Future<ProjectModel?> getProject(int key) async {
    return await _projectDao.getProject(key);
  }

  Future<int> addProject(ProjectModel project) async {
    final key = await _projectDao.insertProject(project);
    project.key = key;
    _projects.add(project);
    notifyListeners();
    return key;
  }

  Future updateProject(ProjectModel project) async {
    await _projectDao.updateProject(project);
    await loadProjects();
  }

  Future<void> deleteProject(int key) async {
    try {
      await _projectDao.deleteProject(key);
      _projects.removeWhere((project) => project.key == key);
      notifyListeners();
    } catch (e) {
      throw Exception('プロジェクトの削除に失敗しました: $e');
    }
  }
}