import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/movie_bloc/movie_bloc.dart';
import '../../data/repositories/movie_repository.dart';
import 'widgets/_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription subscription;
  ConnectivityResult? connectivityResult;

  @override
  initState() {
    super.initState();
    // to check the connection and fetch the api when connection comes back up
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        connectivityResult = result;
      });
    });
  }

  @override
  dispose() {
    super.dispose();

    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(
        movieRepo: context.read<MovieRepository>(),
      ),
      child: HomeScreen(
        connectivityResult: connectivityResult,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.connectivityResult})
      : super(key: key);

  final ConnectivityResult? connectivityResult;

  @override
  Widget build(BuildContext context) {
    context
        .read<MovieBloc>()
        .add(MoviesFetched(connectivityResult: connectivityResult));

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state.status == MovieStatus.initial) {
              return const MovieLoading();
            } else if (state.status == MovieStatus.success) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Movies",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildRecommendedMovieList(context, state.popularMovies),
                    const SizedBox(height: 24),
                    _buildUpcomingMovieList(context, state.upcomingMovies),
                  ],
                ),
              );
            } else {
              return MovieError(errorMessage: state.errorMessage);
            }
          },
        ),
      ),
    );
  }

  Widget _buildRecommendedMovieList(context, movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Recommended",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 260,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: movies.length,
                  itemBuilder: (BuildContext context, int i) {
                    return PopularMovieCard(
                      movie: movies[i],
                      onTapFavorite: () {
                        context.read<MovieBloc>().add(
                              MovieFavoriteToggled(
                                id: movies[i].id,
                              ),
                            );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUpcomingMovieList(context, movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Upcoming Movies",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int i) {
            return UpcomingMovieCard(
              movie: movies[i],
              onTapFavorite: () {
                context.read<MovieBloc>().add(
                      MovieFavoriteToggled(
                        id: movies[i].id,
                      ),
                    );
              },
            );
          },
        ),
      ],
    );
  }
}
