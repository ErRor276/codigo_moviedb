import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/api/movie_api.dart';
import 'data/dao/movie_dao.dart';
import 'data/database/database.dart';
import 'data/repositories/movie_repository.dart';
import 'views/_views.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(myDatabase: MyDatabase()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required myDatabase})
      : _myDatabase = myDatabase,
        super(key: key);

  final MyDatabase _myDatabase;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MovieRepository(
        movieApi: MovieApi(http: http.Client()),
        movieDao: MovieDao(_myDatabase),
      ),
      child: MaterialApp(
        title: 'Codigo Moviedb',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
