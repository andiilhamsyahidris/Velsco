import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series/series.dart';

abstract class SeriesRepository {
  Future<Either<Failure, List<Series>>> getSeries();
}
