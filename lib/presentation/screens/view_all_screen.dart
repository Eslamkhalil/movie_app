import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/business/cubit/movie_cubit.dart';
import 'package:movie_app/business/cubit/movie_state.dart';

import '../widget/build_movie_image.dart';


class ViewAllScreen extends StatelessWidget {
  final String listName;

  const ViewAllScreen({Key? key, required this.listName}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocConsumer<MovieCubit, MovieState>(
      builder: (context, state) {
        debugPrint('view all screen vale : $listName');
        final cubit = MovieCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white10,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(4.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 0,
                ),
                itemBuilder: (context, index) {
                  if(listName == 'upcoming'){
                    return BuildMovieImage(
                      results: cubit.upcomingMovies![index],

                    );

                  }
                  return BuildMovieImage(

                    results: cubit.trendingMovies![index],
                  );
                },
                itemCount:  listName == 'upcoming' ?  cubit.upcomingMovies!.length : cubit.trendingMovies!.length,
              ),
            ),
          ),
        );
      },
      listener: (context, state) {});



}
