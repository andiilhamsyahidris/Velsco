import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series.dart';

class SeriesModel extends Equatable {
  final int id;
  final String title;
  final int start;
  final int end;
  final String? rating;
  final ImageModel images;

  const SeriesModel({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    required this.rating,
    required this.images,
  });

  factory SeriesModel.fromJson(Map<String, dynamic> json) => SeriesModel(
        id: json['id'],
        title: json['title'],
        start: json['startYear'],
        end: json['endYear'],
        rating: json['rating'],
        images: ImageModel.fromJson(json['thumbnail']),
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'startYear': start,
        'endYear': end,
        'rating': rating,
        'images': images,
      };
  Series toEntity() {
    return Series(
      id: id,
      title: title,
      start: start,
      end: end,
      rating: rating,
      images: images.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        start,
        end,
        rating,
        images,
      ];
}
