import 'dart:convert';
import '../models/character.dart';
import 'package:http/http.dart' as http;

class CharacterService {
  Future<List<Character>> getlAllCharacters() async {
    var uri = Uri.parse('https://www.breakingbadapi.com/api/characters');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body).map<Character>((data) => Character.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}

