import 'package:comics/domain/entities/comics.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class ComicsModel extends Equatable {
  const ComicsModel({
    required this.id,
    required this.title,
    required this.pageCount,
    required this.description,
    required this.images,
  });

  final int id;
  final String title;
  final int pageCount;
  final String? description;
  final ImageModel images;

  factory ComicsModel.fromJson(Map<String, dynamic> json) => ComicsModel(
        id: json['id'],
        title: json['title'],
        pageCount: json['pageCount'],
        description: json['description'] ?? '',
        images: ImageModel.fromJson(json['thumbnail']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'pageCount': pageCount,
        'description': description,
        'thumbnail': images
      };
  Comics toEntity() {
    return Comics(
      id: id,
      title: title,
      pageCount: pageCount,
      description: description,
      images: images.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        pageCount,
        description,
        images,
      ];
}
