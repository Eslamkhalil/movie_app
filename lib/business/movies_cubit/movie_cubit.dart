import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/models/person.dart';

import '../../data/models/movie_details_model.dart';
import '../../data/models/movie_model.dart';
import '../../data/repository/fetch_data_repository.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit({required this.moviesRepository}) : super(MovieInitial());

  static MovieCubit get(context) => BlocProvider.of(context);

  final MoviesRepository moviesRepository;
  MovieDetailsModel? movieDetailsModel;
  List<Results>? nowPlayingMovies;
  List<Results>? trendingMovies;
  List<Results>? upcomingMovies;
  List<Person>? persons;

  int pageNumber = 1;
  bool isLoading = false;

  void loadMore(
      {required ScrollController scrollController, required String title}) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          title == 'upcoming') {
        isLoading = true;
        emit(ChangeIsLoadingState());
        getUpcoming(pageNumber: pageNumber += 1);
        isLoading = false;
        emit(ChangeIsLoadingState());
      } else {
        isLoading = true;
        emit(ChangeIsLoadingState());
        getUpcoming(pageNumber: pageNumber = 1);
        isLoading = false;
        emit(ChangeIsLoadingState());
      }
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          title == 'trending') {
        isLoading = true;
        emit(ChangeIsLoadingState());
        getTrending(pageNumber: pageNumber += 1);
        isLoading = false;
        emit(ChangeIsLoadingState());
      } else {
        isLoading = true;
        emit(ChangeIsLoadingState());
        getTrending(pageNumber: pageNumber = 1);
        isLoading = false;
        emit(ChangeIsLoadingState());
      }
    });
  }

  void getPopularPersons() async {
    emit(PopularPersonsLoading());
    await moviesRepository.getPopularPersons().then((value) {
      if (kDebugMode) {
        print('movies_cubit vlaue: ${value!.first}');
      }
      persons = value!;
      emit(PopularPersonsLoaded());
    }).catchError((error) {
      if (kDebugMode) {
        print('movies_cubit Error: ${error.toString()}');
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

  void getTrending({required int pageNumber}) async {
    await moviesRepository
        .getTrendingMovies(pageNumber: pageNumber)
        .then((value) {
      trendingMovies = value.results!;
      emit(TrendingMovieLoaded());
    }).catchError((error) {
      emit(TrendingMovieError(error.toString()));
    });
  }

  void getUpcoming({required int pageNumber}) async {
    emit(UpcomingMovieLoading());
    await moviesRepository
        .getUpcomingMovies(pageNumber: pageNumber)
        .then((value) {
      upcomingMovies = value.results!;

      emit(UpcomingMovieLoaded());
    }).catchError((error) {
      emit(UpcomingMovieError(error.toString()));
    });
  }

  void getMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());
    await moviesRepository.getMovieDetails(movieId).then((value) {
      movieDetailsModel = value;

      emit(MovieDetailsLoaded());
    }).catchError((error) {
      emit(MovieDetailsError(error: error.toString()));
    });
  }
}
