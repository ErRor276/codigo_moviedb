import 'package:drift/drift.dart';

import '../database/database.dart';

part 'movie_dao.g.dart';

// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(
  tables: [PopularMovies, UpcomingMovies],
)
class MovieDao extends DatabaseAccessor<MyDatabase> with _$MovieDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  MovieDao(MyDatabase db) : super(db);

  Future<List<PopularMovie>> getPopularMovies() async =>
      await (select(popularMovies)
            ..orderBy([(t) => OrderingTerm(expression: t.pos)]))
          .get();

  Future<List<UpcomingMovie>> getUpcomingMovies() async =>
      await (select(upcomingMovies)
            ..orderBy([(t) => OrderingTerm(expression: t.pos)]))
          .get();

  Future upsertPopularMovies(List<PopularMovie> popularMovieList) async {
    delete(popularMovies).go();
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        popularMovies,
        [
          ...List.generate(
            popularMovieList.length,
            (i) => PopularMoviesCompanion.insert(
              id: Value(popularMovieList[i].id),
              pos: Value(i),
              title: popularMovieList[i].title,
              voteAverage: popularMovieList[i].voteAverage,
              adult: popularMovieList[i].adult,
              backdropPath: popularMovieList[i].backdropPath,
              genreIds: popularMovieList[i].genreIds,
              originalLanguage: popularMovieList[i].originalLanguage,
              originalTitle: popularMovieList[i].originalTitle,
              overview: popularMovieList[i].overview,
              popularity: popularMovieList[i].popularity,
              posterPath: popularMovieList[i].posterPath,
              releaseDate: popularMovieList[i].releaseDate,
              video: popularMovieList[i].video,
              voteCount: popularMovieList[i].voteCount,
              favorite: popularMovieList[i].favorite,
            ),
          )
        ],
      );
    });
  }

  Future upsertUpcomingMovies(List<UpcomingMovie> upcomingMovieList) async {
    delete(upcomingMovies).go();
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        upcomingMovies,
        [
          ...List.generate(
            upcomingMovieList.length,
            (i) => UpcomingMoviesCompanion.insert(
              id: Value(upcomingMovieList[i].id),
              pos: Value(i),
              title: upcomingMovieList[i].title,
              voteAverage: upcomingMovieList[i].voteAverage,
              adult: upcomingMovieList[i].adult,
              backdropPath: upcomingMovieList[i].backdropPath,
              genreIds: upcomingMovieList[i].genreIds,
              originalLanguage: upcomingMovieList[i].originalLanguage,
              originalTitle: upcomingMovieList[i].originalTitle,
              overview: upcomingMovieList[i].overview,
              popularity: upcomingMovieList[i].popularity,
              posterPath: upcomingMovieList[i].posterPath,
              releaseDate: upcomingMovieList[i].releaseDate,
              video: upcomingMovieList[i].video,
              voteCount: upcomingMovieList[i].voteCount,
              favorite: upcomingMovieList[i].favorite,
            ),
          )
        ],
      );
    });
  }

  Future toggleFavorite(int id, bool value) async {
    await (update(popularMovies)..where((t) => t.id.equals(id))).write(
      PopularMoviesCompanion(
        favorite: Value(value),
      ),
    );

    await (update(upcomingMovies)..where((t) => t.id.equals(id))).write(
      UpcomingMoviesCompanion(
        favorite: Value(value),
      ),
    );
  }
}
