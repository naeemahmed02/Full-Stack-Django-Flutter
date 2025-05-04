import 'dart:convert';

class ProjectModel {
  final int id;
  final String project_title;
  final String project_description;
  final String slug;
  final String github_link;
  final String featured_image;
  final List<int> category; // Multiple categories (IDs)

  ProjectModel({
    required this.id,
    required this.project_title,
    required this.project_description,
    required this.category,
    required this.slug,
    required this.featured_image,
    required this.github_link,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      project_title: json['project_title'],
      project_description: json['project_description'],
      category: List<int>.from(json['category']), // Convert List<dynamic> to List<int>
      slug: json['slug'],
      featured_image: json['featured_image'],
      github_link: json['github_link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_title': project_title,
      'project_description': project_description,
      'category': category,
      'slug': slug,
      'featured_image': featured_image,
      'github_link': github_link,
    };
  }

  static List<ProjectModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProjectModel.fromJson(json)).toList();
  }
}

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static List<CategoryModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
  }
}
