import 'package:flutter/material.dart';
import 'package:movie_app/presentation/utils/helpers_fun.dart';

import '../../constants/end_point.dart';
import '../../data/models/movie_model.dart';
import 'custom_cached_image.dart';

class BuildMovieImage extends StatelessWidget {
  final Results results;

  const BuildMovieImage({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context: context, screen: '/detailsScreen', args: results.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomCachedImage(
                imageUrl: '$imagePath${results.posterPath}',
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 3,
                //fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(
                results.title!,

                style: const TextStyle(
                  fontFamily: 'muli',
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
