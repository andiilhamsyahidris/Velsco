import 'package:comics/data/models/comics_model.dart';
import 'package:equatable/equatable.dart';

class ComicsResponse extends Equatable {
  final List<ComicsModel> comicList;

  const ComicsResponse({required this.comicList});

  factory ComicsResponse.fromJson(Map<String, dynamic> json) => ComicsResponse(
        comicList: List<ComicsModel>.from(
          (json['results'] as List).map((e) => ComicsModel.fromJson(e)),
        ),
      );
  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(
          comicList.map((e) => e.toJson()),
        ),
      };
  @override
  List<Object> get props => [comicList];
}
