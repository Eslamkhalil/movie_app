import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/business/theme_cubit/theme_cubit.dart';

import '../../business/movies_cubit/movie_cubit.dart';
import '../../business/movies_cubit/movie_state.dart';
import '../../constants/end_point.dart';

import '../utils/helpers_fun.dart';
import '../widget/build_movie_image.dart';
import '../widget/build_persons.dart';
import '../widget/custom_cached_image.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_4_outlined),
            onPressed: () {
              ThemeCubit.get(context).toggle();
            },
          ),
        ],
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocConsumer<MovieCubit, MovieState>(
        builder: (context, state) =>
            LayoutBuilder(builder: (context, constraints) {
              var cubit = BlocProvider.of<MovieCubit>(context);
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: cubit.trendingMovies != null &&
                        cubit.upcomingMovies != null
                    ? ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          CarouselSlider.builder(
                              itemCount: cubit.nowPlayingMovies!.length,
                              itemBuilder: (BuildContext context, int index,
                                  int pageViewIndex) {
                                return GestureDetector(
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      ClipRRect(
                                        child: CustomCachedImage(
                                          imageUrl:
                                              '$imagePath${cubit.nowPlayingMovies![index].posterPath}',
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, bottom: 12),
                                        child: Text(
                                          cubit.nowPlayingMovies![index].title!
                                              .toUpperCase(),
                                          overflow: TextOverflow.ellipsis,
                                          style:Theme.of(context).textTheme.subtitle2,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                enableInfiniteScroll: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 500),
                                autoPlay: true,
                                pauseAutoPlayOnTouch: true,
                                viewportFraction: 0.8,
                                enlargeCenterPage: true,
                              )),
                          buildTitles(
                              'Trending Movies',
                              'Get the Trending Movies ',
                              () => navigateTo(
                                  context: context,
                                  screen: '/viewAllScreen',
                                  args: 'trending'),
                          context,
                          ),
                          SizedBox(
                            height: 165,
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    BuildMovieImage(
                                        results: cubit.trendingMovies![index]),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      width: 1,
                                    ),
                                itemCount: cubit.trendingMovies!.length),
                          ),
                          buildTitles(
                              'Upcoming Movies',
                              'Get the Upcoming Movies ',
                              () => navigateTo(
                                  context: context,
                                  screen: '/viewAllScreen',
                                  args: 'upcoming'),
                            context

                          ),
                          SizedBox(
                            height: 165,
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    BuildMovieImage(
                                      results: cubit.upcomingMovies![index],
                                    ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      width: 1,
                                    ),
                                itemCount: cubit.upcomingMovies!.length),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 8.0),
                            child: Text(
                              'Trending persons on this week'.toUpperCase(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          BuildPersons(persons: cubit.persons),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator()),
              );
            }),
        listener: (context, state) {});
  }

  Widget buildTitles(String title, String subtitle, Function onTap ,BuildContext context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                    style: Theme.of(context).textTheme.headline1,),
                  const SizedBox(height: 5),
                  Text(subtitle,
                    style: Theme.of(context).textTheme.subtitle2,),
                ],
              ),
            ),
            TextButton(
              onPressed: () => onTap(),
              child:  Text('view all',
                  style: Theme.of(context).textTheme.bodyText2,),
            )
          ],
        ),
      );

/* Widget buildMovieImage(BuildContext context, Results results) => Padding(
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
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 10),
              child: Text(
                results.title!,
                overflow: TextOverflow.ellipsis,
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
      );*/
}
