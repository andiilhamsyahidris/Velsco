import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series/series.dart';

class SeriesRepositoryImpl implements SeriesRepository {
  final SeriesRemoteDatasource seriesRemoteDatasource;

  SeriesRepositoryImpl({required this.seriesRemoteDatasource});

  @override
  Future<Either<Failure, List<Series>>> getSeries() async {
    try {
      final result = await seriesRemoteDatasource.getSeries();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
