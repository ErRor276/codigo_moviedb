part of 'movie_bloc.dart';

enum MovieStatus { initial, loading, success, failure }

class MovieState extends Equatable {
  const MovieState({
    this.status = MovieStatus.initial,
    this.popularMovies = const [],
    this.upcomingMovies = const [],
    this.errorMessage = "",
  });

  final MovieStatus status;
  final List<Movie> popularMovies;
  final List<Movie> upcomingMovies;
  final String errorMessage;

  MovieState copyWith({
    MovieStatus? status,
    List<Movie>? popularMovies,
    List<Movie>? upcomingMovies,
    String? errorMessage,
  }) {
    return MovieState(
      status: status ?? this.status,
      popularMovies: popularMovies ?? this.popularMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return '''MovieState { status: $status, popularMovies: ${popularMovies.length}, upcomingMovies: ${upcomingMovies.length} errorMessage: $errorMessage }''';
  }

  @override
  List<Object> get props =>
      [status, popularMovies, upcomingMovies, errorMessage];
}
