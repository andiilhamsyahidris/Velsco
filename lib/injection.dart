import 'package:comics/comics.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
    () => ComicsBloc(getComics: locator()),
  );

  locator.registerLazySingleton(() => GetComics(locator()));

  locator.registerLazySingleton<ComicsRepository>(
    () => ComicsRepositoryImpl(comicsRemoteDatasource: locator()),
  );

  locator.registerLazySingleton<ComicsRemoteDatasource>(
    () => ComicsRemoteDatasourceImpl(client: locator()),
  );

  locator.registerLazySingleton(() => http.Client());
}
