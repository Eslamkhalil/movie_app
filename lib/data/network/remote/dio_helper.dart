
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/end_point.dart';

class DioHelper {

  static late Dio dio;

  static init(){
    dio = Dio();
    dio.options.baseUrl = url;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;


  }

 static Future<Response> getPopularMovies () async{

   return await dio.get(popularMoviePath,queryParameters: {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1
    }).then((value) {
      if (kDebugMode) {
        print('getPopularMovies: ' + value.data.toString());
      }
      return value;

    }).catchError((error) {
     if (kDebugMode) {
       print(error.toString());
     }
      return error;
    });

  }

 static Future<Response> getTopRatedMovies () async{

   return await dio.get(topRatedMovie,queryParameters: {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1
    }).then((value) {
      if (kDebugMode) {
        print('getTopRatedMovies: '+value.data.toString());
      }
      return value;

    }).catchError((error) {
     if (kDebugMode) {
       print('getTopRatedMovies : ' + error.toString());
     }
      return error;
    });

  }
 static Future<Response> getTrendingMovies () async{

   return await dio.get(trendingMovie,queryParameters: {
      'api_key': apiKey,

    }).then((value) {
      if (kDebugMode) {
        print('getTrendingMovies :' +value.data.toString());
      }
      return value;

    }).catchError((error) {
     if (kDebugMode) {
       print(error.toString());
     }
      return error;
    });

  }


}