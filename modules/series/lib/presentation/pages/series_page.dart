import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/states/bloc/series_bloc/series_bloc.dart';
import 'package:series/presentation/states/provider/series_provider.dart';
import 'package:series/presentation/widgets/series_card.dart';

class SeriesPage extends StatefulWidget {
  static const route = '/series';

  const SeriesPage({super.key});

  @override
  SeriesPageState createState() => SeriesPageState();
}

class SeriesPageState extends State<SeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<SeriesBloc>().add(FetchSeriesList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Consumer<SeriesProvider>(
            builder: (context, seriesProvider, child) {
              return _buildContent(seriesProvider);
            },
          ),
        ),
      ),
    );
  }

  Column _buildContent(SeriesProvider seriesProvider) {
    if (seriesProvider.isTap == false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl:
                    'http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg',
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
              'Fantastic Four by Dan Slott Vol. 1 (2021)',
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
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: kRed,
                  ),
                  height: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          'Start',
                          style: bodyText.copyWith(
                            color: kRichBlack.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '2021',
                          style: subtitle.copyWith(
                              color: kRichBlack, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  width: 2,
                  height: 60,
                  decoration: const BoxDecoration(color: kRed),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: kRed),
                  ),
                  height: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          'End',
                          style: bodyText.copyWith(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '2021',
                          style: subtitle.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: 80,
                    child: Flexible(
                      child: Text(
                        seriesProvider.rating ?? '',
                        style: bodyText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _buildSubHeading(title: 'Show more', onTap: () {}),
          ),
          BlocBuilder<SeriesBloc, SeriesState>(
            builder: (context, state) {
              if (state is SeriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SeriesError) {
                return const Center(
                  child: CustomInformation(
                    imgPath: 'assets/error.svg',
                    titleInformation: 'Oops, There\'s a Problem',
                    subtitleInformation: 'Wait a moment',
                  ),
                );
              } else if (state is SeriesHasData) {
                final result = state.getSeries;
                return Container(
                  height: 200,
                  padding: const EdgeInsets.only(left: 20),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final data = result[index];
                      return SeriesCard(
                        series: data,
                        images: data.images,
                      );
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
              imageUrl: '${seriesProvider.imgPath}.${seriesProvider.extension}',
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
            seriesProvider.name,
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
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: kRed,
                ),
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        'Start',
                        style: bodyText.copyWith(
                          color: kRichBlack.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '${seriesProvider.start}',
                        style: subtitle.copyWith(
                            color: kRichBlack, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                width: 2,
                height: 60,
                decoration: const BoxDecoration(color: kRed),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: kRed),
                ),
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        'End',
                        style: bodyText.copyWith(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '${seriesProvider.start}',
                        style: subtitle.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 80,
                  child: Flexible(
                    child: Text(
                      seriesProvider.rating ?? '',
                      style: bodyText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: _buildSubHeading(title: 'Show more', onTap: () {}),
        ),
        BlocBuilder<SeriesBloc, SeriesState>(
          builder: (context, state) {
            if (state is SeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SeriesError) {
              return const Center(
                child: CustomInformation(
                  imgPath: 'assets/error.svg',
                  titleInformation: 'Oops, There\'s a Problem',
                  subtitleInformation: 'Wait a moment',
                ),
              );
            } else if (state is SeriesHasData) {
              final result = state.getSeries;
              return Container(
                height: 200,
                padding: const EdgeInsets.only(left: 20),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final data = result[index];
                    return SeriesCard(
                      series: data,
                      images: data.images,
                    );
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
