import 'dart:io';

import 'package:character/character.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersRemoteDatasource charactersRemoteDatasource;

  CharactersRepositoryImpl({required this.charactersRemoteDatasource});

  @override
  Future<Either<Failure, List<Character>>> getCharacters() async {
    try {
      final result = await charactersRemoteDatasource.getCharacters();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
