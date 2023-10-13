import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character_mode.dart';
import 'package:http/http.dart' as http;

class ApiProvider with ChangeNotifier {
  final url = 'rickandmortyapi.com';
  List<Character> characters = [];

  Future<void> getChracters(int page) async {
    final result = await http.get(Uri.https(url, "/api/character", {
      'page': page.toString(),
    }));
    final response = characterResponseFromJson(result.body);
    characters.addAll(response.results!);
    notifyListeners();
    //print(response.results);
  }
}
