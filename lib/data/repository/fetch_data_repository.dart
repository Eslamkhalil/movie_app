import 'package:flutter/foundation.dart';
import 'package:movie_app/data/network/remote/dio_helper.dart';

import '../models/popular_movie_model.dart';

class Repository {
  static Future<PopularMovieModel> getPopularMovies() async {
    final result = await DioHelper.getPopularMovies();
    if (kDebugMode) {
      print(result.data.toString());
    }
    return PopularMovieModel.fromJson(result.data);
  }

  static Future<PopularMovieModel> topRatedMovies() async {
    final result = await DioHelper.getTopRatedMovies();
    if (kDebugMode) {
      print(result.data.toString());
    }
    return PopularMovieModel.fromJson(result.data);
  }

  static Future<PopularMovieModel> getTrendingMovies() async {
    final result = await DioHelper.getTrendingMovies();
    if (kDebugMode) {
      print(result.data.toString());
    }
    return PopularMovieModel.fromJson(result.data);
  }
}
