import 'package:character/character.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CharactersRepository {
  Future<Either<Failure, List<Character>>> getCharacters();
}
