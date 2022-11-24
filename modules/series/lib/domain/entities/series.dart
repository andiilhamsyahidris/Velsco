import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class Series extends Equatable {
  int id;
  String title;
  int start;
  int end;
  String? rating;
  Images images;

  Series({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    required this.rating,
    required this.images,
  });

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
