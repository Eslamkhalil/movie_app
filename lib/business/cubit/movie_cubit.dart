import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/models/person.dart';

import '../../data/models/movie_model.dart';
import '../../data/repository/fetch_data_repository.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit({required this.moviesRepository}) : super(MovieInitial());

  static MovieCubit get(context) => BlocProvider.of(context);

  final MoviesRepository moviesRepository;
  List<Results> nowPlayingMovies = [];
  List<Results> trendingMovies = [];
  List<Results> upcomingMovies = [];
  List<Person> persons = [];



  void getPopularPersons() async {
    emit(PopularPersonsLoading());
    await moviesRepository.getPopularPersons().then((value) {
      if (kDebugMode) {
        print('cubit vlaue: ${value!.first}');
      }
      persons = value!;
      emit(PopularPersonsLoaded());
    }).catchError((error) {
      if (kDebugMode) {
        print('cubit Error: ${error.toString()}');
      }
      emit(PopularPersonsError(error: error.toString()));
    });

  }
  void getNowPlaying() async {

    emit(NowPlayingMovieLoading());
    await moviesRepository.getNowPlayingMovies().then((value) {

      nowPlayingMovies = value.results!;
      emit(NowPlayingMovieLoaded());
    }).catchError((error) {
      emit(NowPlayingMovieError(error.toString()));
    });
  }
  
  void getTrending()async{

    await moviesRepository.getTrendingMovies().then((value) {

      trendingMovies = value.results!;
      emit(TrendingMovieLoaded());
    }).catchError((error) {
      emit(TrendingMovieError(error.toString()));
    });
    
  }

  void getPopular()async{

    emit(UpcomingMovieLoading());
    await moviesRepository.getUpcomingMovies().then((value) {

        upcomingMovies = value.results!;

      emit(UpcomingMovieLoaded());
    }).catchError((error) {
      emit(UpcomingMovieError(error.toString()));
    });
  }
}
