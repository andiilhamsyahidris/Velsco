import 'package:comics/comics.dart';
import 'package:comics/presentation/pages/comics_page.dart';
import 'package:comics/presentation/state/provider/comics_provider.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
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
        ChangeNotifierProvider(
          create: (_) => ComicsProvider(),
        ),
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
          }
        },
      ),
    );
  }
}
