import 'package:character/domain/entities/character.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class CharactersModel extends Equatable {
  final int id;
  final String name;
  final String? description;
  final ImageModel images;

  const CharactersModel({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
  });

  factory CharactersModel.fromJson(Map<String, dynamic> json) =>
      CharactersModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        images: ImageModel.fromJson(json['thumbnail']),
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'thumbnail': images,
      };
  Character toEntity() {
    return Character(
      id: id,
      name: name,
      description: description,
      images: images.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        images,
      ];
}
