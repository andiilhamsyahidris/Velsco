import 'package:character/character.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetCharacters {
  final CharactersRepository repository;

  GetCharacters(this.repository);

  Future<Either<Failure, List<Character>>> execute() {
    return repository.getCharacters();
  }
}
