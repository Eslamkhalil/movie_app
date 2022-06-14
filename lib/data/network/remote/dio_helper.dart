import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_details_model.dart';

import '../../../constants/end_point.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio();
    dio.options.baseUrl = url;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;

    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<Response> getUpcomingMovies({required int pageNumber}) async {
    return await dio.get(upcomingMoviePath, queryParameters: {
      'api_key': apiKey,
      'language': 'en-US',
      'page': pageNumber
    }).then((value) {
      return value;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return error;
    });
  }

  Future<Response> getNowPlayingMovies() async {
    return await dio.get(nowPlayingMoviePath, queryParameters: {
      'api_key': apiKey,
    }).then((value) {
      return value;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return error;
    });
  }

 /* Future<Response> getTopRatedMovies() async {
    return await dio.get(topRatedMovie, queryParameters: {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1
    }).then((value) {
      return value;
    }).catchError((error) {
      if (kDebugMode) {
        print('getTopRatedMovies : ' + error.toString());
      }
      return error;
    });
  }*/

  Future<Response> getTrendingMovies({required int pageNumber}) async {
    return await dio.get(trendingMovie, queryParameters: {
      'api_key': apiKey,
      'page': pageNumber,
    }).then((value) {
      return value;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return error;
    });
  }

  Future<Response> getPopularPersons() async {
    return await dio.get(popularPersonsPath, queryParameters: {
      'api_key': apiKey,
    }).then((value) {
      return value;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return error;
    });
  }

   Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    return await dio.get('$movieDetailsPath$movieId', queryParameters: {
      'api_key': apiKey,
      'language': 'en-US',
    }).then((value) async {
      MovieDetailsModel movieDetailsModel =
          MovieDetailsModel.fromJson(value.data);
      movieDetailsModel.trailerId = await getTrailerId(movieId);
      movieDetailsModel.movieImage = await getMovieImage(movieId);
      movieDetailsModel.castList = await getCastList(movieId);

      if (kDebugMode) {
        print('movie length ${movieDetailsModel.movieImage!.posters.length}');
      }

      return movieDetailsModel;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return error;
    });
  }

  static getMovieImage(int movieId) async {
    return await dio.get('/movie/$movieId/images', queryParameters: {
      'api_key': apiKey,
      'language': 'en-US',
    }).then((value) {
      return MovieImagesModel.fromJson(value.data);
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return error;
    });
  }

  static Future<String?> getTrailerId(int id) async {
    return await dio.get('/movie/$id/videos', queryParameters: {
      'api_key': apiKey,
    }).then((value) {
      var youtubeId = value.data['results'][0]['key'];
      return youtubeId;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return error;
    });
  }

  static getCastList(int movieId) async {
    return await dio.get('/movie/$movieId/credits', queryParameters: {
      'api_key': apiKey,
    }).then((value) {
      var list = value.data['cast'] as List;
      List<Cast> castList = list
          .map((i) => Cast(
                name: i['name'],
                character: i['character'],
                profilePath: i['profile_path'],
              ))
          .toList();
      return castList;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return error;
    });
  }
}
