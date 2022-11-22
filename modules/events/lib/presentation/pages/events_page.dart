import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:events/presentation/states/bloc/events_bloc/events_bloc.dart';
import 'package:events/presentation/states/provider/events_provider.dart';
import 'package:events/presentation/widgets/events_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class EventsPage extends StatefulWidget {
  static const route = '/events';

  const EventsPage({super.key});

  @override
  EventsPageState createState() => EventsPageState();
}

class EventsPageState extends State<EventsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<EventsBloc>().add(FetchEventsList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Consumer<EventsProvider>(
            builder: (context, eventProvider, child) {
              return _buildContent(eventProvider);
            },
          ),
        ),
      ),
    );
  }

  Column _buildContent(EventsProvider eventsProvider) {
    if (eventsProvider.isTap == false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl:
                    'http://i.annihil.us/u/prod/marvel/i/mg/9/40/51ca10d996b8b.jpg',
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
              'Acts of Vengeancel',
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
              'Loki sets about convincing the super-villains of Earth to attack heroes other than those they normally fight in an attempt to destroy the Avengers to absolve his guilt over inadvertently creating the team in the first place.',
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
          BlocBuilder<EventsBloc, EventsState>(
            builder: (context, state) {
              if (state is EventsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is EventsError) {
                return const Center(
                  child: CustomInformation(
                    imgPath: 'assets/error.svg',
                    titleInformation: 'Oops, There\'s a Problem',
                    subtitleInformation: 'Wait a moment',
                  ),
                );
              } else if (state is EventsHasData) {
                final result = state.getEvents;
                return Container(
                  height: 200,
                  padding: const EdgeInsets.only(left: 20),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final data = result[index];
                      return EventsCard(events: data, images: data.images);
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
              imageUrl: '${eventsProvider.imgPath}.${eventsProvider.extension}',
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
            eventsProvider.name,
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
            eventsProvider.description ?? '',
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
        BlocBuilder<EventsBloc, EventsState>(
          builder: (context, state) {
            if (state is EventsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is EventsError) {
              return const Center(
                child: CustomInformation(
                  imgPath: 'assets/error.svg',
                  titleInformation: 'Oops, There\'s a Problem',
                  subtitleInformation: 'Wait a moment',
                ),
              );
            } else if (state is EventsHasData) {
              final result = state.getEvents;
              return Container(
                height: 200,
                padding: const EdgeInsets.only(left: 20),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final data = result[index];
                    return EventsCard(events: data, images: data.images);
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
