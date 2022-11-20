import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInformation extends StatelessWidget {
  final String imgPath;
  final String titleInformation;
  final String subtitleInformation;

  const CustomInformation({
    super.key,
    required this.imgPath,
    required this.titleInformation,
    required this.subtitleInformation,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              imgPath,
              width: 150,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              titleInformation,
              textAlign: TextAlign.center,
              style: subtitle,
            ),
            Text(
              subtitleInformation,
              textAlign: TextAlign.center,
              style: bodyText,
            ),
          ],
        ),
      ),
    );
  }
}
