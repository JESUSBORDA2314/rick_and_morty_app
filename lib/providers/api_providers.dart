import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character_mode.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/models/episode_mode.dart';

class ApiProvider with ChangeNotifier {
  final url = 'rickandmortyapi.com';
  List<Character> characters = [];
  List<Episode> episodes = [];
  //Este METODO TRAE A TODOS LOS PERSONAJES
  Future<void> getChracters(int page) async {
    final result = await http.get(Uri.https(url, "/api/character", {
      'page': page.toString(),
    }));
    final response = characterResponseFromJson(result.body);
    characters.addAll(response.results!);
    notifyListeners();
  }

  //Este metodo trae los episodios por personaje

  Future<List<Episode>> getEpisodes(Character character) async {
    episodes = [];
    for (var i = 0; i < character.episode!.length; i++) {
      final result = await http.get(Uri.parse(character.episode![i]));
      final response = episodeFromJson(result.body);
      episodes.add(response);
      notifyListeners();
    } 
    return episodes;
  }

  //Este trae los personajes dependiedo de un String
  Future<List<Character>> getCharacter(String name) async {
    final result =
        await http.get(Uri.https(url, "/api/character/", {"name": name}));
    final response = characterResponseFromJson(result.body);

    return response.results!;
  }
}
