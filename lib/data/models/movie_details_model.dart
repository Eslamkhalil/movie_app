class MovieDetailsModel {
  int? id;
  String? overview;
  String? backdropPath;
  dynamic budget;
  String? releaseDate;
  dynamic runtime;
  double? voteAverage;
  String? trailerId;
  MovieImagesModel? movieImage;
  List<Cast>? castList;

  MovieDetailsModel({
    this.id,
    this.overview,
    this.backdropPath,
    this.budget,
    this.releaseDate,
    this.runtime,
    this.voteAverage,
    this.trailerId,
    this.movieImage,
    this.castList,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'],
      overview: json['overview'],
      backdropPath: json['backdrop_path'],
      budget: json['budget'],
      releaseDate: json['release_date'],
      runtime: json['runtime'],
      voteAverage: json['vote_average'],
    );
  }
}

class MovieImagesModel {
  final List<ScreenShot> backdrops;
  final List<ScreenShot> posters;

  MovieImagesModel({required this.backdrops, required this.posters});

  factory MovieImagesModel.fromJson(Map<String, dynamic> json) {
    return MovieImagesModel(
      backdrops: (json['backdrops'] as List)
          .map((e) => ScreenShot.fromJson(e))
          .toList(),
      posters:
          (json['posters'] as List).map((e) => ScreenShot.fromJson(e)).toList(),
    );
  }
}

class ScreenShot {
  final String aspect;
  final String imagePath;
  final int height;
  final int width;
  final String countryCode;
  final double voteAverage;
  final int voteCount;

  ScreenShot(
      {required this.aspect,
      required this.imagePath,
      required this.height,
      required this.width,
      required this.countryCode,
      required this.voteAverage,
      required this.voteCount});

  factory ScreenShot.fromJson(Map<String, dynamic> json) => ScreenShot(
        aspect: json["aspect_ratio"].toString(),
        imagePath: json["file_path"],
        height: json["height"],
        width: json["width"],
        countryCode: json["iso_639_1"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );
}

class Cast {
  String? name;
  String? character;
  String? profilePath;

  Cast({this.name, this.profilePath, this.character});

  factory Cast.fromJson(dynamic json) {
    if (json == null) {
      return Cast();
    }

    return Cast(
        name: json['name'],
        profilePath: json['profile_path'],
        character: json['character']);
  }
}
