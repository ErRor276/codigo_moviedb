part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MoviesFetched extends MovieEvent {
  MoviesFetched({required this.connectivityResult});

  final ConnectivityResult? connectivityResult;
}

class MovieFavoriteToggled extends MovieEvent {
  MovieFavoriteToggled({required this.id});

  final int id;
}
