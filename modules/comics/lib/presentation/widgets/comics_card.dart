import 'package:cached_network_image/cached_network_image.dart';
import 'package:comics/comics.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComicsCard extends StatelessWidget {
  final Images images;
  final Comics comics;

  const ComicsCard({Key? key, required this.images, required this.comics})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ComicsProvider>(
      builder: (context, comicsProvider, child) {
        return InkWell(
          onTap: () {
            comicsProvider.isTap = true;
            comicsProvider.imgPath = images.path;
            comicsProvider.extension = images.extension;
            comicsProvider.title = comics.title;
            comicsProvider.description = comics.description;
            comicsProvider.page = '${comics.pageCount} Pages';
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
