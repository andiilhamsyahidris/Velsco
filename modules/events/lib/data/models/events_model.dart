import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:events/domain/entities/events.dart';

class EventsModel extends Equatable {
  final int id;
  final String title;
  final String? description;
  final ImageModel images;

  const EventsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        images: ImageModel.fromJson(json['thumbnail']),
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'thumbnail': images,
      };
  Events toEntity() {
    return Events(
      id: id,
      title: title,
      description: description,
      images: images.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        images,
      ];
}
