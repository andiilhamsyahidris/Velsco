import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/states/provider/series_provider.dart';
import 'package:series/series.dart';

class SeriesCard extends StatelessWidget {
  final Images images;
  final Series series;

  const SeriesCard({
    super.key,
    required this.images,
    required this.series,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SeriesProvider>(
      builder: (context, seriesProvider, child) {
        return InkWell(
          onTap: () {
            seriesProvider.isTap = true;
            seriesProvider.imgPath = images.path;
            seriesProvider.extension = images.extension;
            seriesProvider.name = series.title;
            seriesProvider.rating = series.rating ?? '';
            seriesProvider.start = series.start;
            seriesProvider.end = series.end;
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
