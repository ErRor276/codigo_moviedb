import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class PopularMovies extends Table {
  IntColumn get id => integer()();
  IntColumn get pos => integer().withDefault(const Constant(0))();
  TextColumn get title => text()();
  RealColumn get voteAverage => real()();
  BoolColumn get adult => boolean()();
  TextColumn get backdropPath => text()();
  TextColumn get genreIds => text()();
  TextColumn get originalLanguage => text()();
  TextColumn get originalTitle => text()();
  TextColumn get overview => text()();
  RealColumn get popularity => real()();
  TextColumn get posterPath => text()();
  TextColumn get releaseDate => text()();
  BoolColumn get video => boolean()();
  IntColumn get voteCount => integer()();
  BoolColumn get favorite => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

class UpcomingMovies extends Table {
  IntColumn get id => integer()();
  IntColumn get pos => integer().withDefault(const Constant(0))();
  TextColumn get title => text()();
  RealColumn get voteAverage => real()();
  BoolColumn get adult => boolean()();
  TextColumn get backdropPath => text()();
  TextColumn get genreIds => text()();
  TextColumn get originalLanguage => text()();
  TextColumn get originalTitle => text()();
  TextColumn get overview => text()();
  RealColumn get popularity => real()();
  TextColumn get posterPath => text()();
  TextColumn get releaseDate => text()();
  BoolColumn get video => boolean()();
  IntColumn get voteCount => integer()();
  BoolColumn get favorite => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [PopularMovies, UpcomingMovies],
)
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // we added the dueDate property in the change from version 1 to version 2
          await m.addColumn(popularMovies, popularMovies.pos);
          await m.addColumn(upcomingMovies, upcomingMovies.pos);
        }
      });
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'moviedb.sqlite'));
    return NativeDatabase(file);
  });
}
