import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:events/events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsCard extends StatelessWidget {
  final Images images;
  final Events events;

  const EventsCard({required this.images, required this.events});

  @override
  Widget build(BuildContext context) {
    return Consumer<EventsProvider>(
      builder: (context, eventProvider, child) {
        return InkWell(
          onTap: () {
            eventProvider.isTap = true;
            eventProvider.imgPath = images.path;
            eventProvider.extension = images.extension;
            eventProvider.name = events.title;
            eventProvider.desc = events.description ?? '';
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: '${images.path}.${images.extension}',
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
