abstract class MovieState {}

class MovieInitial extends MovieState {}

class NowPlayingMovieLoading extends MovieState {}

class NowPlayingMovieLoaded extends MovieState {}

class NowPlayingMovieError extends MovieState {
  final String error;

  NowPlayingMovieError(this.error);
}


class TrendingMovieLoading extends MovieState {}

class TrendingMovieLoaded extends MovieState {}

class TrendingMovieError extends MovieState {
  final String error;

  TrendingMovieError(this.error);
}


class UpcomingMovieLoading extends MovieState {}

class UpcomingMovieLoaded extends MovieState {}

class UpcomingMovieError extends MovieState {
  final String error;

  UpcomingMovieError(this.error);
}


class PopularPersonsLoading extends MovieState {}

class PopularPersonsLoaded extends MovieState {}

class PopularPersonsError extends MovieState {
   dynamic error;

  PopularPersonsError({this.error});
}

class MovieDetailsLoading extends MovieState {}

class MovieDetailsLoaded extends MovieState {}

class MovieDetailsError extends MovieState {
  dynamic error;

  MovieDetailsError({this.error});
}
