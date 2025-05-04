import 'package:flutter/material.dart';
import 'package:djangoblogapp/models/ArticlesModel.dart';
import 'package:djangoblogapp/services/ArticlesServices.dart';

class ArticlesProviders extends ChangeNotifier{
  List<ArticlesModel> _articlesList = [];
  List<ArticlesModel> _categories = [];
  bool _is_loading = false;
  String _error = '';

  // Getter Methods
  List<ArticlesModel> get articlesList => _articlesList;
  List<ArticlesModel> get categories => _categories;
  bool get is_loading => _is_loading;
  String get error => _error;

  // Fetch Articles against category
  Future<void> loadArticlesAgainstCategory(String category) async{
    _is_loading = true;
    notifyListeners();

    try{
      _articlesList = await Articlesservices().getArticlesAgainstCategory(category);
      _is_loading = false;
      notifyListeners();
    }
    catch (e){
      _error = e.toString();
      _is_loading = false;
      notifyListeners();
    }
  }

  // Fetch Article and update the state
  Future<void> loadArticles() async{
    _is_loading = true;
    notifyListeners();

    try{
      // Call the ArticleServices to fetch the data
      _articlesList = await Articlesservices().getArticles();
      _is_loading = false;
      notifyListeners();
    }catch (e){
      _error = e.toString();
      _is_loading = false;
      notifyListeners();
    }
  }




}