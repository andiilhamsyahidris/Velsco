import 'package:character/character.dart';
import 'package:equatable/equatable.dart';

class CharactersResponse extends Equatable {
  final List<CharactersModel> characterList;

  const CharactersResponse({required this.characterList});

  factory CharactersResponse.fromJson(Map<String, dynamic> json) =>
      CharactersResponse(
        characterList: List<CharactersModel>.from(
          (json['results'] as List).map(
            (e) => CharactersModel.fromJson(e),
          ),
        ),
      );
  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(
          characterList.map((e) => e.toJson()),
        )
      };
  @override
  List<Object> get props => [characterList];
}
