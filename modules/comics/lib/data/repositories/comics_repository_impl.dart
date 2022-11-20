import 'dart:io';

import 'package:comics/comics.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class ComicsRepositoryImpl implements ComicsRepository {
  final ComicsRemoteDatasource comicsRemoteDatasource;

  ComicsRepositoryImpl({required this.comicsRemoteDatasource});

  @override
  Future<Either<Failure, List<Comics>>> getComics() async {
    try {
      final result = await comicsRemoteDatasource.getComics();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
