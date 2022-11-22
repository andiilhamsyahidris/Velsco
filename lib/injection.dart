import 'package:character/character.dart';
import 'package:character/presentation/states/bloc/bloc/characters_bloc.dart';
import 'package:comics/comics.dart';
import 'package:events/events.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
    () => ComicsBloc(getComics: locator()),
  );
  locator.registerFactory(
    () => CharactersBloc(getCharacters: locator()),
  );
  locator.registerFactory(
    () => EventsBloc(getEvents: locator()),
  );

  locator.registerLazySingleton(() => GetComics(locator()));
  locator.registerLazySingleton(() => GetCharacters(locator()));
  locator.registerLazySingleton(() => GetEvents(locator()));

  locator.registerLazySingleton<ComicsRepository>(
    () => ComicsRepositoryImpl(comicsRemoteDatasource: locator()),
  );
  locator.registerLazySingleton<CharactersRepository>(
    () => CharactersRepositoryImpl(charactersRemoteDatasource: locator()),
  );
  locator.registerLazySingleton<EventsRepository>(
    () => EventsRepositoryImpl(eventsRemoteDatasource: locator()),
  );

  locator.registerLazySingleton<ComicsRemoteDatasource>(
    () => ComicsRemoteDatasourceImpl(client: locator()),
  );
  locator.registerLazySingleton<CharactersRemoteDatasource>(
    () => CharactersRemoteDatasourceImpl(client: locator()),
  );
  locator.registerLazySingleton<EventsRemoteDatasource>(
    () => EventsRemoteDatasourceImpl(client: locator()),
  );

  locator.registerLazySingleton(() => http.Client());
}
