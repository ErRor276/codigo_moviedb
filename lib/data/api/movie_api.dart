import 'dart:convert';

import 'package:http/http.dart';

import '../../common/constants/_constants.dart';
import '../../common/models/_models.dart';

class MovieApi {
  const MovieApi({required Client http}) : _http = http;

  final Client _http;

  Future<List<Movie>> getPopularMovies() async {
    // use dotenv for production
    final response = await _http.get(
      Uri.parse('$apiURL/movie/popular?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final results = jsonDecode(response.body)['results'] as List;
      return [
        ...List.generate(results.length, (i) => Movie.fromJson(results[i]))
      ];
    } else {
      throw const Error(message: 'Failed to load popular movies');
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await _http.get(
      Uri.parse('$apiURL/movie/upcoming?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final results = jsonDecode(response.body)['results'] as List;
      return [
        ...List.generate(results.length, (i) => Movie.fromJson(results[i]))
      ];
    } else {
      throw const Error(message: 'Failed to load upcoming movies');
    }
  }
}
