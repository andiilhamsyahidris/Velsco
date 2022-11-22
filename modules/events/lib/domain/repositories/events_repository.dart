import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:events/events.dart';

abstract class EventsRepository {
  Future<Either<Failure, List<Events>>> getEvents();
}
