import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class Events extends Equatable {
  int id;
  String title;
  String? description;
  Images images;

  Events({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        images,
      ];
}
