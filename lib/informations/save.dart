import 'package:app_exams/informations/person.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

List<Person> allPeople = [];
SharedPreferences sharedPreferences;

Future<bool> saveList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> temp = [];

  for (var item in allPeople) {
    Map<String, dynamic> itemPerson = item.toMap();
    temp.add(jsonEncode(itemPerson));
  }

  return await prefs.setStringList('people', temp);
}

Future<void> getList() async {
  allPeople = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('people') || prefs.getStringList('people').isEmpty) {
    allPeople = [];
  } else {
    for (var item in prefs.getStringList('people')) {
      Map mapObject = jsonDecode(item);
      // use the fromMap constructor to convert the Map to a Payment object
      Person person = Person.fromMap(mapObject);
      // print the members of the payment class
      allPeople.add(person);
    }
  }
}
