import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/movies_cubit/movie_cubit.dart';
import '../../business/movies_cubit/movie_state.dart';
import '../widget/build_movie_image.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({Key? key, required this.listName}) : super(key: key);
  final String listName;

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    MovieCubit.get(context)
        .loadMore(scrollController: scrollController, title: widget.listName);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<MovieCubit, MovieState>(
      builder: (context, state) {
        debugPrint('view all screen vale : ${widget.listName}');
        final cubit = MovieCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.white10,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.builder(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(4.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 0,
                ),
                itemBuilder: (context, index) {
                  if (widget.listName == 'upcoming') {
                    return BuildMovieImage(
                      results: cubit.upcomingMovies![index],
                    );
                  }
                  return BuildMovieImage(
                    results: cubit.trendingMovies![index],
                  );
                },
                itemCount: widget.listName == 'upcoming'
                    ? cubit.upcomingMovies!.length
                    : cubit.trendingMovies!.length,
              ),
            ),
          ),
        );
      },
      listener: (context, state) {});
}
