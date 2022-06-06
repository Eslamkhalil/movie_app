import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/business/cubit/movie_cubit.dart';
import 'package:movie_app/data/repository/fetch_data_repository.dart';
import 'package:movie_app/presentation/screens/home.dart';

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
                movieCubit..getNowPlaying()..getTrending()..getPopular()..getPopularPersons(),
                child: Home(),
              )),
        );
    }
    return null;
  }
}
