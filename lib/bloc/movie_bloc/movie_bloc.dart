import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/models/_models.dart';
import '../../data/repositories/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

enum Connection { empty, offline, online }

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({required movieRepo})
      : _movieRepo = movieRepo,
        super(const MovieState()) {
    on<MovieEvent>(
      (event, emit) async {
        try {
          if (event is MoviesFetched) {
            final movieState = await _onPopularMovieFetched(event);
            emit(movieState);
          } else if (event is MovieFavoriteToggled) {
            final movieState = await _onMovieFavoriteToggled(event);
            emit(movieState);
          }
        } catch (e) {
          emit(
            state.copyWith(
              status: MovieStatus.failure,
              errorMessage: e.toString(),
            ),
          );
        }
      },
    );
  }

  final MovieRepository _movieRepo;

  Future<MovieState> _onPopularMovieFetched(MoviesFetched event) async {
    try {
      List<Movie> popularMovies;
      List<Movie> upcomingMovies;
      if (_isConnected(event.connectivityResult)) {
        print("Calls Api and updates db");
        popularMovies = await _movieRepo.fetchMovies(MovieRequestType.popular);
        upcomingMovies =
            await _movieRepo.fetchMovies(MovieRequestType.upcoming);
      } else {
        print("Calls Db");
        popularMovies =
            await _movieRepo.getMoviesFromDb(MovieRequestType.popular);
        upcomingMovies =
            await _movieRepo.getMoviesFromDb(MovieRequestType.upcoming);
        if (popularMovies.isEmpty || upcomingMovies.isEmpty) {
          print("No Data in Db");
          return state.copyWith(
            status: MovieStatus.failure,
            errorMessage: "Need Internet Connection for first time usage",
          );
        }
      }

      return state.copyWith(
        status: MovieStatus.success,
        popularMovies: [...popularMovies],
        upcomingMovies: [...upcomingMovies],
      );
    } catch (e) {
      return state.copyWith(
        status: MovieStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<MovieState> _onMovieFavoriteToggled(MovieFavoriteToggled event) async {
    try {
      bool changedValue = false;
      final updatedPopularMovies = state.popularMovies.map((movie) {
        if (movie.id == event.id) {
          changedValue = movie.favorite;
          return movie.copyWith(favorite: !movie.favorite);
        }
        return movie;
      }).toList();
      final updatedUpcomingMovies = state.upcomingMovies.map((movie) {
        if (movie.id == event.id) {
          changedValue = movie.favorite;
          return movie.copyWith(favorite: !movie.favorite);
        }
        return movie;
      }).toList();
      // final updatedUpcomingMovies = state.upcomingMovies
      //     .map((movie) => movie.id == event.id
      //         ? movie.copyWith(favorite: !movie.favorite)
      //         : movie)
      //     .toList();
      await _movieRepo.toggleFavorite(event.id, changedValue);

      return state.copyWith(
        status: MovieStatus.success,
        popularMovies: updatedPopularMovies,
        upcomingMovies: updatedUpcomingMovies,
      );
    } catch (e) {
      return state.copyWith(
        status: MovieStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  bool _isConnected(ConnectivityResult? result) {
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet;
  }
}
