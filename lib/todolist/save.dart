import 'package:app_exams/todolist/project.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

List<Project> allProject = [];
SharedPreferences sharedPreferences;

Future<bool> saveList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> temp = [];

  for (var item in allProject) {
    Map<String, dynamic> itemProject = item.toMap();
    temp.add(jsonEncode(itemProject));
  }

  return await prefs.setStringList('allproject', temp);
}

Future<void> getList() async {
  allProject = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> projectLoad = prefs.getStringList('allproject');

  if (!prefs.containsKey('allproject') || projectLoad.isEmpty) {
    allProject = [];
  } else {
    for (var item in projectLoad) {
      Map mapObject = jsonDecode(item);
      Project project = Project.fromMap(mapObject);
      allProject.add(project);
    }
  }
}
