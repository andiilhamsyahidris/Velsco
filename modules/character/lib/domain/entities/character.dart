import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class Character extends Equatable {
  int id;
  String name;
  String? description;
  Images images;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        images,
      ];
}
