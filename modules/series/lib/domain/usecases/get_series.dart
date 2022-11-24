import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series/series.dart';

class GetSeries {
  final SeriesRepository repository;

  GetSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getSeries();
  }
}
