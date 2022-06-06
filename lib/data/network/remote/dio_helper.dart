import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/end_point.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio();
    dio.options.baseUrl = url;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
  }

   Future<Response> getUpcomingMovies() async {
    return await dio.get(upcomingMoviePath, queryParameters: {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1
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

   Future<Response> getTopRatedMovies() async {
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
  }

   Future<Response> getTrendingMovies() async {
    return await dio.get(trendingMovie, queryParameters: {
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

  Future<Response> getPopularPersons ()async{
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
}
