import 'dart:convert';

import 'package:comics/data/models/comics_model.dart';
import 'package:comics/data/models/comics_response.dart';
import 'package:core/core.dart';
import 'package:http/http.dart' as http;

abstract class ComicsRemoteDatasource {
  Future<List<ComicsModel>> getComics();
}

class ComicsRemoteDatasourceImpl implements ComicsRemoteDatasource {
  final http.Client client;

  ComicsRemoteDatasourceImpl({required this.client});

  @override
  Future<List<ComicsModel>> getComics() async {
    final response =
        await client.get(Uri.parse('$baseUrl/comics?ts=1&$apikey&$hash'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["data"];
      return ComicsResponse.fromJson(data).comicList;
    } else {
      throw ServerException();
    }
  }
}
