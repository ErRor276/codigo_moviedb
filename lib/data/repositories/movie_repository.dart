import '../../common/models/_models.dart';
import '../api/movie_api.dart';
import '../dao/movie_dao.dart';

enum MovieRequestType { popular, upcoming }

class MovieRepository {
  const MovieRepository({
    required MovieApi movieApi,
    required MovieDao movieDao,
  })  : _movieApi = movieApi,
        _movieDao = movieDao;

  final MovieApi _movieApi;
  final MovieDao _movieDao;

  Future<List<Movie>> fetchMovies(MovieRequestType requestType) async {
    final List<Movie> movies;
    switch (requestType) {
      case MovieRequestType.popular:
        movies = await _movieApi.getPopularMovies();
        final popularMovies = [
          ...List.generate(movies.length, (i) => movies[i].toPopularMovie(i))
        ];
        await _movieDao.upsertPopularMovies(popularMovies);
        break;
      case MovieRequestType.upcoming:
        movies = await _movieApi.getUpcomingMovies();
        final upcomingMovies = [
          ...List.generate(movies.length, (i) => movies[i].toUpcomingMovie(i))
        ];
        await _movieDao.upsertUpcomingMovies(upcomingMovies);
        break;
      default:
        movies = await _movieApi.getPopularMovies();
        final popularMovies = [
          ...List.generate(movies.length, (i) => movies[i].toPopularMovie(i))
        ];
        await _movieDao.upsertPopularMovies(popularMovies);
    }
    return movies;
  }

  Future<List<Movie>> getMoviesFromDb(MovieRequestType requestType) async {
    final List<Movie> movies;
    switch (requestType) {
      case MovieRequestType.popular:
        final popularMovies = await _movieDao.getPopularMovies();
        movies = [
          ...List.generate(
            popularMovies.length,
            (i) => Movie.fromPopularMovie(popularMovies[i]),
          )
        ];
        break;
      case MovieRequestType.upcoming:
        final upcomingMovies = await _movieDao.getUpcomingMovies();
        movies = [
          ...List.generate(
            upcomingMovies.length,
            (i) => Movie.fromUpcomingMovie(upcomingMovies[i]),
          )
        ];
        break;
      default:
        final popularMovies = await _movieDao.getPopularMovies();
        movies = [
          ...List.generate(
            popularMovies.length,
            (i) => Movie.fromPopularMovie(popularMovies[i]),
          )
        ];
    }
    return movies;
  }

  Future toggleFavorite(int id, bool value) async {
    return await _movieDao.toggleFavorite(id, value);
  }
}
