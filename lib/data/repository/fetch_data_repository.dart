import 'package:movie_app/data/models/person.dart';
import 'package:movie_app/data/network/remote/dio_helper.dart';

import '../models/movie_details_model.dart';
import '../models/movie_model.dart';

class MoviesRepository {
  late DioHelper dioHelper;

  MoviesRepository({required this.dioHelper});

  Future<MovieModel> getUpcomingMovies({required int pageNumber}) async {
    final result = await dioHelper.getUpcomingMovies(pageNumber: pageNumber);

    return MovieModel.fromJson(result.data);
  }

  /*Future<MovieModel> topRatedMovies() async {
    final result = await dioHelper.getTopRatedMovies();

    return MovieModel.fromJson(result.data);
  }*/

  Future<List<Person>?> getPopularPersons() async {
    try {
      final result = await dioHelper.getPopularPersons();
      var persons = result.data['results'];

      return persons.map<Person>((person) => Person.fromJson(person)).toList();
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<MovieModel> getTrendingMovies({required int pageNumber}) async {
    final result = await dioHelper.getTrendingMovies(pageNumber: pageNumber);

    return MovieModel.fromJson(result.data);
  }

  Future<MovieModel> getNowPlayingMovies() async {
    final result = await dioHelper.getNowPlayingMovies();

    return MovieModel.fromJson(result.data);
  }

  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    return await dioHelper.getMovieDetails(movieId);
  }
}
