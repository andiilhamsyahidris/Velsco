import 'package:comics/comics.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetComics {
  final ComicsRepository repository;

  GetComics(this.repository);

  Future<Either<Failure, List<Comics>>> execute() {
    return repository.getComics();
  }
}
