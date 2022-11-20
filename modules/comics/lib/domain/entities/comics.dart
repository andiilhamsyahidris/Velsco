import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class Comics extends Equatable {
  Comics({
    required this.id,
    required this.title,
    required this.pageCount,
    required this.description,
    required this.images,
  });

  int id;
  String title;
  int pageCount;
  String? description;
  Images images;

  @override
  List<Object?> get props => [
        id,
        title,
        pageCount,
        description,
        images,
      ];
}
