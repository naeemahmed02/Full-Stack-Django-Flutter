import 'package:flutter/material.dart';
import 'package:naeemahmed/models/ArticlesModel.dart';
import 'package:naeemahmed/services/ArticlesServices.dart';

class Articlesproviders extends ChangeNotifier{
  List<ArticlesModel> _articlesList = [];
  bool _is_loading = false;
  String _error = '';

  // Getter Methods
  List<ArticlesModel> get articlesList => _articlesList;
  bool get is_loading => _is_loading;
  String get error => _error;

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