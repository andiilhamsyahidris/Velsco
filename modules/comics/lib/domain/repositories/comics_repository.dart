import 'package:comics/comics.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class ComicsRepository {
  Future<Either<Failure, List<Comics>>> getComics();
}
