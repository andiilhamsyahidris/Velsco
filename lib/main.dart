import 'package:character/character.dart';
import 'package:character/presentation/states/bloc/bloc/characters_bloc.dart';
import 'package:comics/comics.dart';
import 'package:comics/presentation/pages/comics_page.dart';
import 'package:core/core.dart';
import 'package:events/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/pages/series_page.dart';
import 'package:series/presentation/states/bloc/series_bloc/series_bloc.dart';
import 'package:series/presentation/states/provider/series_provider.dart';
import 'package:velsco/injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<ComicsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<CharactersBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<EventsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesBloc>(),
        ),
        ChangeNotifierProvider(
          create: (_) => ComicsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CharactersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EventsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SeriesProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          scaffoldBackgroundColor: kRichBlack,
          primaryColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const ComicsPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const ComicsPage());
            case CharactersPage.route:
              return MaterialPageRoute(builder: (_) => const CharactersPage());
            case EventsPage.route:
              return MaterialPageRoute(builder: (_) => const EventsPage());
            case SeriesPage.route:
              return MaterialPageRoute(builder: (_) => const SeriesPage());
          }
        },
      ),
    );
  }
}
