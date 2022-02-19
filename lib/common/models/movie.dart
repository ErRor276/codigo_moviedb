import '../../data/database/database.dart';
import 'package:equatable/equatable.dart';
import '../../utils/_utils.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final double voteAverage;
  final bool adult;
  final String backdropPath;
  final List genreIds;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final bool video;
  final int voteCount;
  final bool favorite;

  const Movie({
    required this.id,
    required this.title,
    required this.voteAverage,
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.video,
    required this.voteCount,
    this.favorite = false,
  });

  Movie copyWith({
    int? id,
    String? title,
    double? voteAverage,
    bool? favorite,
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    bool? video,
    int? voteCount,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      voteAverage: voteAverage ?? this.voteAverage,
      favorite: favorite ?? this.favorite,
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      video: video ?? this.video,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  PopularMovie toPopularMovie(int index) => PopularMovie(
        id: id,
        pos: index,
        title: title,
        voteAverage: voteAverage,
        adult: adult,
        backdropPath: backdropPath,
        genreIds: genreIds.toCommasString(),
        originalLanguage: originalLanguage,
        originalTitle: originalTitle,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        releaseDate: releaseDate,
        video: video,
        voteCount: voteCount,
        favorite: favorite,
      );

  UpcomingMovie toUpcomingMovie(int index) => UpcomingMovie(
        id: id,
        pos: index,
        title: title,
        voteAverage: voteAverage,
        adult: adult,
        backdropPath: backdropPath,
        genreIds: genreIds.toCommasString(),
        originalLanguage: originalLanguage,
        originalTitle: originalTitle,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        releaseDate: releaseDate,
        video: video,
        voteCount: voteCount,
        favorite: favorite,
      );

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      voteAverage: json['vote_average'].toDouble(),
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: json['genre_ids'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      video: json['video'],
      voteCount: json['vote_count'],
    );
  }

  factory Movie.fromPopularMovie(PopularMovie popularMovie) {
    return Movie(
      id: popularMovie.id,
      title: popularMovie.title,
      voteAverage: popularMovie.voteAverage,
      favorite: popularMovie.favorite,
      adult: popularMovie.adult,
      backdropPath: popularMovie.backdropPath,
      genreIds: popularMovie.genreIds.toIntList(),
      originalLanguage: popularMovie.originalLanguage,
      originalTitle: popularMovie.originalTitle,
      overview: popularMovie.overview,
      popularity: popularMovie.popularity,
      posterPath: popularMovie.posterPath,
      releaseDate: popularMovie.releaseDate,
      video: popularMovie.video,
      voteCount: popularMovie.voteCount,
    );
  }

  factory Movie.fromUpcomingMovie(UpcomingMovie upcomingMovie) {
    return Movie(
      id: upcomingMovie.id,
      title: upcomingMovie.title,
      voteAverage: upcomingMovie.voteAverage,
      favorite: upcomingMovie.favorite,
      adult: upcomingMovie.adult,
      backdropPath: upcomingMovie.backdropPath,
      genreIds: upcomingMovie.genreIds.toIntList(),
      originalLanguage: upcomingMovie.originalLanguage,
      originalTitle: upcomingMovie.originalTitle,
      overview: upcomingMovie.overview,
      popularity: upcomingMovie.popularity,
      posterPath: upcomingMovie.posterPath,
      releaseDate: upcomingMovie.releaseDate,
      video: upcomingMovie.video,
      voteCount: upcomingMovie.voteCount,
    );
  }

  @override
  List<Object> get props => [id, title, voteAverage, favorite, releaseDate];

  @override
  String toString() {
    return '''Movie{ id: $id, title: $title, voteAverage: $voteAverage, favorite: $favorite }''';
  }
}
