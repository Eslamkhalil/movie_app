
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/presentation/widget/build_persons.dart';
import 'package:movie_app/presentation/widget/custom_cached_image.dart';

import 'package:url_launcher/url_launcher_string.dart';


import '../../business/movies_cubit/movie_cubit.dart';
import '../../business/movies_cubit/movie_state.dart';
import '../../constants/end_point.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
  }) : super(key: key);
 /* void _launchUrl(String url) async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }*/
  // MediaQuery.of(context).size.height / 2
  @override
  Widget build(BuildContext context) {
    final cubit = MovieCubit.get(context);
    return BlocConsumer<MovieCubit, MovieState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: cubit.movieDetailsModel != null
                  ? ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomCachedImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/original/${cubit.movieDetailsModel!.backdropPath}',
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height / 2),
                              IconButton(
                                onPressed: ()  =>  launchUrlString(
                                   'https://www.youtube.com/watch?v=${cubit.movieDetailsModel!.trailerId}'),
                                icon: const Icon(Icons.play_arrow_outlined,
                                    size: 45),
                                color: Colors.white,
                              ),
                              Positioned(
                                bottom: 15,
                                left: 20,
                                right: 8,
                                child: Text(
                                  cubit.movieDetailsModel!.title!.toUpperCase(),
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ),
                            ],
                          ),
                        ),
                         Padding(
                          padding:
                          const  EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Text(
                            'Over View',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: Text(
                            cubit.movieDetailsModel!.overview!,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                         Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Text(
                            'Screen Shots',
                            style:Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        cubit.movieDetailsModel!.movieImage!.backdrops
                                .isNotEmpty
                            ? ListView.separated(
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Stack(
                                        alignment: Alignment.bottomLeft,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CustomCachedImage(
                                              imageUrl:
                                                  '$screenShotsImagePath${cubit.movieDetailsModel!.movieImage!.backdrops}',
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3,
                                              //fit: BoxFit.fill,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 8),
                                itemCount: cubit.movieDetailsModel!.movieImage!
                                    .backdrops.length)
                            : CustomCachedImage(
                                imageUrl: '',
                                width: MediaQuery.of(context).size.width / 1.5,
                                height: MediaQuery.of(context).size.height / 5,
                              ),
                         Padding(
                          padding:
                          const  EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Text(
                            'Cast',
                            style:Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        BuildPersons(
                            persons: cubit.movieDetailsModel!.castList!),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          );
        },
        listener: (context, state) {});
  }
}
