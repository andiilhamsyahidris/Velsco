import 'package:cached_network_image/cached_network_image.dart';
import 'package:character/character.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharactersCard extends StatelessWidget {
  final Images images;
  final Character characters;

  const CharactersCard({
    Key? key,
    required this.characters,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CharactersProvider>(
      builder: (context, charactersProvider, child) {
        return InkWell(
          onTap: () {
            charactersProvider.isTap = true;
            charactersProvider.imgPath = images.path;
            charactersProvider.extension = images.extension;
            charactersProvider.name = characters.name;
            charactersProvider.desc = characters.description ?? '';
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
