import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/data/repository/fetch_data_repository.dart';
import 'package:movie_app/presentation/screens/details_screen.dart';
import 'package:movie_app/presentation/screens/home.dart';
import 'package:movie_app/presentation/screens/view_all_screen.dart';

import 'business/movies_cubit/movie_cubit.dart';
import 'data/network/remote/dio_helper.dart';

class AppRouter {
  late MoviesRepository moviesRepository;
  late MovieCubit movieCubit;

  AppRouter() {
    moviesRepository = MoviesRepository(dioHelper: DioHelper());
    movieCubit = MovieCubit(moviesRepository: moviesRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: ((context) => BlocProvider(
                create: (context) =>
                movieCubit..getNowPlaying()..getTrending(pageNumber: movieCubit.pageNumber)..getUpcoming(pageNumber: movieCubit.pageNumber)..getPopularPersons(),
                child: Home(),
              )),
        );
      case '/detailsScreen':
        final id = settings.arguments as int ;
        return MaterialPageRoute(builder: (context) =>  BlocProvider<MovieCubit>.value(
          value: movieCubit..getMovieDetails(id),
          child: const DetailsScreen(),));
      case '/viewAllScreen':
        final title = settings.arguments as String;
        return MaterialPageRoute(builder: (context) => BlocProvider<MovieCubit>.value(
          value: movieCubit,
          child:  ViewAllScreen(listName: title),
        ));

    }
    return null;
  }
}
