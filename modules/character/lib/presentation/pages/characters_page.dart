import 'package:cached_network_image/cached_network_image.dart';
import 'package:character/presentation/states/bloc/bloc/characters_bloc.dart';
import 'package:character/presentation/states/provider/characters_provider.dart';
import 'package:character/presentation/widgets/characters_card.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CharactersPage extends StatefulWidget {
  static const route = '/characters';

  const CharactersPage({super.key});

  @override
  CharactersPageState createState() => CharactersPageState();
}

class CharactersPageState extends State<CharactersPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<CharactersBloc>().add(FetchCharacterList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Consumer<CharactersProvider>(
            builder: (context, charactersProvider, child) {
              return _buildContent(charactersProvider);
            },
          ),
        ),
      ),
    );
  }

  Column _buildContent(CharactersProvider charactersProvider) {
    if (charactersProvider.isTap == false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl:
                    'http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg',
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [kRichBlack, Colors.transparent])),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [kRichBlack.withOpacity(0.1), Colors.transparent],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              '3-D Man',
              style: title,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width - 40,
            decoration: const BoxDecoration(color: kRed),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              charactersProvider.description ?? '',
              style: bodyText,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _buildSubHeading(title: 'Show more', onTap: () {}),
          ),
          const SizedBox(
            height: 15,
          ),
          BlocBuilder<CharactersBloc, CharactersState>(
            builder: (context, state) {
              if (state is CharactersLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CharactersError) {
                return const Center(
                  child: CustomInformation(
                    imgPath: 'assets/error.svg',
                    titleInformation: 'Oops, There\'s a Problem',
                    subtitleInformation: 'Wait a moment',
                  ),
                );
              } else if (state is CharactersHasData) {
                final result = state.getCharacters;
                return Container(
                  height: 200,
                  padding: const EdgeInsets.only(left: 20),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final data = result[index];
                      return CharactersCard(
                          characters: data, images: data.images);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemCount: result.length,
                  ),
                );
              }
              return const Center(
                child: CustomInformation(
                  imgPath: 'assets/empty.svg',
                  titleInformation: 'Oops Data Not Found',
                  subtitleInformation: 'Please try again',
                ),
              );
            },
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            CachedNetworkImage(
              imageUrl:
                  '${charactersProvider.imgPath}.${charactersProvider.extension}',
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [kRichBlack, Colors.transparent])),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [kRichBlack.withOpacity(0.1), Colors.transparent],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, '/home'),
                icon: const Icon(Icons.arrow_back_ios_rounded),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            charactersProvider.name,
            style: title,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 2,
          width: MediaQuery.of(context).size.width - 40,
          decoration: const BoxDecoration(color: kRed),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            charactersProvider.description ?? '',
            style: bodyText,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: _buildSubHeading(title: 'Show more', onTap: () {}),
        ),
        BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
            if (state is CharactersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CharactersError) {
              return const Center(
                child: CustomInformation(
                  imgPath: 'assets/error.svg',
                  titleInformation: 'Oops, There\'s a Problem',
                  subtitleInformation: 'Wait a moment',
                ),
              );
            } else if (state is CharactersHasData) {
              final result = state.getCharacters;
              return Container(
                height: 200,
                padding: const EdgeInsets.only(left: 20),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final data = result[index];
                    return CharactersCard(
                        characters: data, images: data.images);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemCount: result.length,
                ),
              );
            }
            return const Center(
              child: CustomInformation(
                imgPath: 'assets/empty.svg',
                titleInformation: 'Oops Data Not Found',
                subtitleInformation: 'Please try again',
              ),
            );
          },
        ),
      ],
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: subtitle,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text('See More'),
                Icon(
                  Icons.arrow_forward_ios,
                  color: kRed,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
