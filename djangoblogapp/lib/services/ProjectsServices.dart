import 'dart:convert';

import 'package:djangoblogapp/models/ProjectModel.dart';
import 'package:djangoblogapp/services/ServicesEndpoints.dart';
import 'package:http/http.dart' as http;

class ProjectServices{

  Future<List<ProjectModel>> fetchProject() async{
    try{
      // Make a GET request at the api
      final response = await http.get(Uri.parse(Servicesendpoints.PROJECTS_URL));
      // Check if the response has status code of 200
      if (response.statusCode == 200){
        print(response.body);
        // decode the json response body into a dynamic list
        List<dynamic> data = jsonDecode(response.body);
        // Converting list to project list using fromJsonList method
        return ProjectModel.fromJsonList(data);
      }
      else{
        throw Exception("Error occurred during fetch project");
      }
    }
    catch (e){
      throw Exception("Error: $e");
    }
  }
}