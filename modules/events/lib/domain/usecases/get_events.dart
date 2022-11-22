import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:events/domain/entities/events.dart';
import 'package:events/domain/repositories/events_repository.dart';

class GetEvents {
  final EventsRepository repository;

  GetEvents(this.repository);

  Future<Either<Failure, List<Events>>> execute() {
    return repository.getEvents();
  }
}
