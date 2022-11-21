part of 'characters_bloc.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

class CharactersEmpty extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersError extends CharactersState {
  final String message;

  const CharactersError(this.message);
}

class CharactersHasData extends CharactersState {
  final List<Character> getCharacters;

  const CharactersHasData(this.getCharacters);

  @override
  List<Object> get props => [getCharacters];
}
