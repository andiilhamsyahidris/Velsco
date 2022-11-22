import 'dart:convert';

import 'package:character/character.dart';
import 'package:core/core.dart';
import 'package:http/http.dart' as http;

abstract class CharactersRemoteDatasource {
  Future<List<CharactersModel>> getCharacters();
}

class CharactersRemoteDatasourceImpl implements CharactersRemoteDatasource {
  final http.Client client;

  CharactersRemoteDatasourceImpl({required this.client});

  @override
  Future<List<CharactersModel>> getCharacters() async {
    final response =
        await client.get(Uri.parse('$baseUrl/characters?ts=1&$apikey&$hash'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["data"];
      return CharactersResponse.fromJson(data).characterList;
    } else {
      throw ServerException();
    }
  }
}
