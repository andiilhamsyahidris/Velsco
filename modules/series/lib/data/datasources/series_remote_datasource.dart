import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:series/series.dart';

abstract class SeriesRemoteDatasource {
  Future<List<SeriesModel>> getSeries();
}

class SeriesRemoteDatasourceImpl implements SeriesRemoteDatasource {
  final http.Client client;

  SeriesRemoteDatasourceImpl({required this.client});

  @override
  Future<List<SeriesModel>> getSeries() async {
    final response =
        await client.get(Uri.parse('$baseUrl/series?ts=1&$apikey&$hash'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["data"];
      return SeriesResponse.fromJson(data).seriesList;
    } else {
      throw ServerException();
    }
  }
}
