import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class PokiApi {
  int? count;
  List<Map>? pokinames = [];
  List<Map>? types = [];
  String? description = "";

  Future<void> requestNames() async {
    var url = Uri.https('pokeapi.co', '/api/v2/pokemon', {'limit': '100000'});
    // Await the http get response, then decode the json-formatted response.

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      int id = 0;
      for (var item in jsonResponse['results']) {
        pokinames?.add({"id": id, "name": item["name"].toString()});
        id++;
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> requestTypes(String id) async {
    var url = Uri.https('pokeapi.co', '/api/v2/pokemon/$id');
    // Await the http get response, then decode the json-formatted response.

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      int id = 0;
      for (var item in jsonResponse["types"]) {
        if (item["type"]["name"] == "grass") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFF78C84F"});
        } else if (item["type"]["name"] == "poison") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFF9F409F"});
        } else if (item["type"]["name"] == "normal") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFFA7A877"});
        } else if (item["type"]["name"] == "fire") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFFF08030"});
        } else if (item["type"]["name"] == "water") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFF6790F0"});
        } else if (item["type"]["name"] == "electric") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFFF9CF30"});
        } else if (item["type"]["name"] == "ice") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFF99D7D8"});
        } else if (item["type"]["name"] == "fighting") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFFC13128"});
        } else if (item["type"]["name"] == "ground") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFFE1BF68"});
        } else if (item["type"]["name"] == "flying") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFFA890F0"});
        } else if (item["type"]["name"] == "psychic") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFFF95887"});
        } else if (item["type"]["name"] == "bug") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFFA3AE30"});
        } else if (item["type"]["name"] == "rock") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFF928561"});
        } else if (item["type"]["name"] == "ghost") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFF705898"});
        } else if (item["type"]["name"] == "dark") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFF6F5848"});
        } else if (item["type"]["name"] == "dragon") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFF7138F8"});
        } else if (item["type"]["name"] == "steel") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFFB8B8D0"});
        } else if (item["type"]["name"] == "fairy") {
          types!.add(
              {"name": item["type"]["name"].toString(), "color": "0xFFECB3BA"});
        }
        ;
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> requesDescription(String id) async {
    var url = Uri.https('pokeapi.co', '/api/v2/pokemon-species/$id');
    // Await the http get response, then decode the json-formatted response.

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      description =
          jsonResponse["flavor_text_entries"][0]["flavor_text"].toString();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
