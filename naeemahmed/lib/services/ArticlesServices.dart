import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:naeemahmed/models/ArticlesModel.dart';

import 'ServicesEndpoints.dart';

class Articlesservices {

  // Function to fetch list of articles from the API
  Future<List<ArticlesModel>> getArticles() async {
    try {
      // Make a GET request to the API endpoint
      final response = await http.get(Uri.parse(Servicesendpoints.ARTICLES_URL));

      // Check if the response status is successful (HTTP 200 OK)
      if (response.statusCode == 200) {
        // Decode the JSON response body into a dynamic list
        List<dynamic> data = json.decode(response.body);
        // print(response.body.toString());

        // Use the model's fromJsonList method to convert the list into a list of ArticlesModel
        return ArticlesModel.fromJsonList(data);
      } else {
        // If the server did not return a 200 response,
        // throw an exception to handle it in the provider or UI
        throw Exception("Failed to load articles");
      }
    } catch (e) {
      // Catch any error (e.g. network issue, JSON parsing error)
      // print("Error fetching article: $e");
      throw Exception("Error occurred in fetching articles");
    }
  }

  String BASE_URL = Servicesendpoints.BASE_URL;
  // Function to get single Article using slug
  Future<ArticlesModel> getSingleArticle(String slug) async{
    try{
      // Storing the response into response variable
      final response = await http.get(Uri.parse('${BASE_URL}articles/${slug}/'));
      if (response.statusCode == 200){
        // decode the json response into single object
        var data = json.decode(response.body);
        return ArticlesModel.fromJson(data);
      }
      else{
        throw Exception("Failed to load the article");
      }
    }
    catch (e){
      throw Exception(e);
    }
  }
}
