import 'package:djangoblogapp/models/ProjectModel.dart';
import 'package:flutter/cupertino.dart';

import '../services/ProjectsServices.dart';

class ProjectProvider extends ChangeNotifier {
  // All fetched projects
  List<ProjectModel> _allProjects = [];

  // Filtered projects (used in UI)
  List<ProjectModel> _filteredProjects = [];

  bool _isLoading = false;
  String _error = '';

  // Getters
  List<ProjectModel> get projectList => _filteredProjects;
  bool get is_laoding => _isLoading;
  String get error => _error;

  // Load projects from service and initialize both lists
  Future<void> loadProjects() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allProjects = await ProjectServices().fetchProject();
      _filteredProjects = _allProjects;
      _isLoading = false;
      _error = '';
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Filter logic based on user input
  void filterProjects(String query) {
    if (query.isEmpty) {
      _filteredProjects = _allProjects;
    } else {
      _filteredProjects = _allProjects.where((project) {
        return project.project_title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
