import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:events/data/datasources/events_remote_datasource.dart';
import 'package:events/domain/entities/events.dart';
import 'package:events/domain/repositories/events_repository.dart';

class EventsRepositoryImpl implements EventsRepository {
  final EventsRemoteDatasource eventsRemoteDatasource;

  EventsRepositoryImpl({required this.eventsRemoteDatasource});

  @override
  Future<Either<Failure, List<Events>>> getEvents() async {
    try {
      final result = await eventsRemoteDatasource.getEvents();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure(''));
    }
  }
}
