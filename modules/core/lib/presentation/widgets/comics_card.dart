import 'package:cached_network_image/cached_network_image.dart';
import 'package:comics/comics.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComicsCard extends StatefulWidget {
  final Images images;
  final Comics comics;

  const ComicsCard({Key? key, required this.images, required this.comics})
      : super(key: key);

  @override
  State<ComicsCard> createState() => _ComicsCardState();
}

class _ComicsCardState extends State<ComicsCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ComicsProvider>(
      builder: (context, comicsProvider, child) {
        return InkWell(
          onTap: () {
            comicsProvider.isTap = true;
            comicsProvider.imgPath = widget.images.path;
            comicsProvider.extension = widget.images.extension;
            comicsProvider.title = widget.comics.title;
            comicsProvider.description = widget.comics.description;
            comicsProvider.page = '${widget.comics.pageCount} Pages';
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: '${widget.images.path}.${widget.images.extension}',
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
