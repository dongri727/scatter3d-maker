import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../database/project_dao.dart';

class ProjectProvider extends ChangeNotifier {
  final ProjectDao _projectDao = ProjectDao();
  List<ProjectModel> _projects = [];

  List<ProjectModel> get projects => _projects;

  Future<void> loadProjects() async {
    _projects = await _projectDao.getAllProjects();
    notifyListeners();
  }

  Future<ProjectModel?> getProject(int key) async {
    return await _projectDao.getProject(key);
  }

  Future<int> addProject(ProjectModel project) async {
    final key = await _projectDao.insertProject(project);
    project.key = key;
    _projects.add(project);
    notifyListeners(); // リストを再読み込み
    return key;
  }

  Future updateProject(ProjectModel project) async {
    await _projectDao.updateProject(project);
    await loadProjects();
  }

  Future<void> deleteProject(int key) async {
    await _projectDao.deleteProject(key);
    await loadProjects(); // リストを再読み込み
  }
}