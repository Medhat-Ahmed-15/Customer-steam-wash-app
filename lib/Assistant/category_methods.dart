import 'package:customer_steam_wash_app/Models/categoryBlueprint.dart';
import 'dart:convert';
import 'package:customer_steam_wash_app/global_variables.dart';
import 'package:http/http.dart' as http;

Future<List<CategoryBlueprint>> getCategories() async {
  List<CategoryBlueprint> categoriesList = [];
  String url = 'https://car-spa.io/api/services';

  var res = await http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-access-token': userAuthToken
    },
  );

  String jSonData = res.body;
  var decodeData = jsonDecode(jSonData);

  if (decodeData['accepted'] == true) {
    var categoriesListData = decodeData['services'];

//to convert the json file which contain list of maps to normal list
    categoriesList = (categoriesListData as List)
        .map((index) => CategoryBlueprint.fromjson(index))
        .toList();
  }

  return categoriesList;
}
