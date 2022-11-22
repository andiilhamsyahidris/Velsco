import 'package:character/character.dart';
import 'package:comics/comics.dart';
import 'package:core/core.dart';
import 'package:events/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ComicsPage extends StatefulWidget {
  const ComicsPage({super.key});

  @override
  ComicsPageState createState() => ComicsPageState();
}

class ComicsPageState extends State<ComicsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<ComicsBloc>().add(FetchComicsList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        decoration: const BoxDecoration(color: kRichBlack),
        child: SafeArea(
          child: Column(
            children: [
              Image.asset(
                'assets/logo.png',
                height: 250,
                fit: BoxFit.cover,
              ),
              const ListTile(
                leading: Icon(Icons.menu_book),
                title: Text('Comics'),
                trailing: Icon(
                  Icons.arrow_right,
                  color: kRed,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle_sharp),
                title: const Text('Characters'),
                trailing: const Icon(
                  Icons.arrow_right,
                  color: kRed,
                ),
                onTap: () => Navigator.pushNamed(context, CharactersPage.route),
              ),
              const ListTile(
                leading: Icon(Icons.supervisor_account_rounded),
                title: Text('Creators'),
                trailing: Icon(
                  Icons.arrow_right,
                  color: kRed,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.event),
                title: const Text('Events'),
                trailing: const Icon(
                  Icons.arrow_right,
                  color: kRed,
                ),
                onTap: () => Navigator.pushNamed(context, EventsPage.route),
              ),
              const ListTile(
                leading: Icon(Icons.featured_play_list_rounded),
                title: Text('Series'),
                trailing: Icon(
                  Icons.arrow_right,
                  color: kRed,
                ),
              ),
              const ListTile(
                leading: Icon(Icons.auto_stories_rounded),
                title: Text('Stories'),
                trailing: Icon(
                  Icons.arrow_right,
                  color: kRed,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        // shadowColor: Colors.transparent,
        title: Image.asset(
          'assets/logo.png',
          width: 70,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: kWhite,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Consumer<ComicsProvider>(
            builder: (context, comicsProvider, child) {
              if (comicsProvider.isTap == false) {
                return Stack(
                  children: [
                    Image.network(
                      'http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg',
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: kRichBlack.withOpacity(0.5),
                      ),
                    )
                  ],
                );
              }
              return Stack(
                children: [
                  Image.network(
                    '${comicsProvider.imgPath}.${comicsProvider.extension}',
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: kRichBlack.withOpacity(0.5),
                    ),
                  )
                ],
              );
            },
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.only(bottom: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    'Marvel Comics',
                    style: subtitle,
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: BlocBuilder<ComicsBloc, ComicsState>(
                    builder: (context, state) {
                      if (state is ComicsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ComicsError) {
                        return const CustomInformation(
                            imgPath: 'assets/error.svg',
                            titleInformation: 'Oops, There\'s a Problem',
                            subtitleInformation: 'Wait a moment');
                      } else if (state is ComicsHasData) {
                        final result = state.getComics;
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final data = result[index];
                            return Card(
                              child: ComicsCard(
                                images: data.images,
                                comics: data,
                              ),
                            );
                          },
                          itemCount: result.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                        );
                      } else {
                        return const CustomInformation(
                            imgPath: 'assets/empty.svg',
                            titleInformation: 'Oops Data Not Found',
                            subtitleInformation: 'Please try again');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                margin: const EdgeInsets.only(top: 120),
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: scrollController,
                      child: Consumer<ComicsProvider>(
                        builder: (context, comicsProvider, child) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Text(
                                      'More About',
                                      style: bodyText,
                                    ),
                                    const Icon(Icons.keyboard_arrow_down_sharp)
                                  ],
                                ),
                              ),
                              Text(
                                _showTitle(comicsProvider),
                                style: title,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 2,
                                child: Container(
                                  decoration: const BoxDecoration(color: kRed),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                _showPages(comicsProvider),
                                style: subtitle,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Flexible(
                                child: Text(
                                  _showDesc(comicsProvider) ?? '',
                                  style: bodyText,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Flexible(
                                child: Text(
                                  'Marvel Comics',
                                  style: subtitle,
                                ),
                              ),
                              SizedBox(
                                height: 200,
                                child: BlocBuilder<ComicsBloc, ComicsState>(
                                  builder: (context, state) {
                                    if (state is ComicsLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state is ComicsError) {
                                      return const CustomInformation(
                                          imgPath: 'assets/error.svg',
                                          titleInformation:
                                              'Oops, There\'s a Problem',
                                          subtitleInformation: 'Wait a moment');
                                    } else if (state is ComicsHasData) {
                                      final result = state.getComics;
                                      return ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final data = result[index];
                                          return Card(
                                            child: ComicsCard(
                                              images: data.images,
                                              comics: data,
                                            ),
                                          );
                                        },
                                        itemCount: result.length,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          width: 10,
                                        ),
                                      );
                                    } else {
                                      return const CustomInformation(
                                          imgPath: 'assets/empty.svg',
                                          titleInformation:
                                              'Oops Data Not Found',
                                          subtitleInformation:
                                              'Please try again');
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _showTitle(ComicsProvider comicsProvider) {
    if (comicsProvider.isTap == false) {
      return 'Marvel Previews (2017)';
    }
    return comicsProvider.title;
  }

  String? _showDesc(ComicsProvider comicsProvider) {
    if (comicsProvider.isTap == false) {
      return '';
    }
    return comicsProvider.description;
  }

  String _showPages(ComicsProvider comicsProvider) {
    if (comicsProvider.isTap == false) {
      return '112 Pages';
    }
    if (comicsProvider.page.contains('0')) {
      return 'Unkown Pages';
    }
    return comicsProvider.page;
  }
}
