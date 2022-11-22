import 'package:equatable/equatable.dart';
import 'package:events/data/models/events_model.dart';

class EventsResponse extends Equatable {
  final List<EventsModel> eventList;

  const EventsResponse({required this.eventList});

  factory EventsResponse.fromJson(Map<String, dynamic> json) => EventsResponse(
        eventList: List<EventsModel>.from(
          (json['results'] as List).map((e) => EventsModel.fromJson(e)),
        ),
      );
  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(
          eventList.map((e) => e.toJson()),
        ),
      };
  @override
  List<Object> get props => [eventList];
}
