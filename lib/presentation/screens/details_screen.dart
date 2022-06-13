
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/business/cubit/movie_cubit.dart';
import 'package:movie_app/business/cubit/movie_state.dart';
import 'package:movie_app/presentation/widget/build_persons.dart';
import 'package:movie_app/presentation/widget/custom_cached_image.dart';


import '../../constants/end_point.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
  }) : super(key: key);

  // MediaQuery.of(context).size.height / 2
  @override
  Widget build(BuildContext context) {
    final cubit = MovieCubit.get(context);
    return BlocConsumer<MovieCubit, MovieState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white10,
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
                                onPressed: () {
                                  debugPrint('Clicked');
                                  print('Clicked');
                                  /*    final youtubeUrl = '$baseYoutubePath${cubit.movieDetailsModel!.trailerId}';
                                  if( await canLaunchUrlString(youtubeUrl)){
                                  await   launchUrlString(youtubeUrl);

                                  }*/
                                },
                                icon: const Icon(Icons.play_arrow_outlined,
                                    size: 40),
                                color: Colors.white,
                              ),
                              Positioned(
                                bottom: 15,
                                left: 20,
                                right: 8,
                                child: Text(
                                  cubit.movieDetailsModel!.title!.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'muli',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Text(
                            'Over View',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'muli',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: Text(
                            cubit.movieDetailsModel!.overview!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'muli',
                            ),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Text(
                            'Screen Shots',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'muli',
                            ),
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
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Text(
                            'Cast',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'muli',
                            ),
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
