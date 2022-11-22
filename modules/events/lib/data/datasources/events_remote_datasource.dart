import 'dart:convert';

import 'package:core/common/constant.dart';
import 'package:core/common/exception.dart';
import 'package:events/data/models/events_model.dart';
import 'package:events/data/models/events_response.dart';
import 'package:http/http.dart' as http;

abstract class EventsRemoteDatasource {
  Future<List<EventsModel>> getEvents();
}

class EventsRemoteDatasourceImpl implements EventsRemoteDatasource {
  final http.Client client;

  EventsRemoteDatasourceImpl({required this.client});

  @override
  Future<List<EventsModel>> getEvents() async {
    final response =
        await client.get(Uri.parse('$baseUrl/events?ts=1&$apikey&$hash'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["data"];
      return EventsResponse.fromJson(data).eventList;
    } else {
      throw ServerException();
    }
  }
}
