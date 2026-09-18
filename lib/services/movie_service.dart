import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/movie.dart';

class MovieService {
  final String baseUrl = 'https://fooapi.com/api/movies';


  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(
      Uri.parse(baseUrl),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data);

      final List movies = data['data'];

      return movies
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      throw Exception(
        'Failed to load movies',
      );
    }
  }


Future<List<Movie>> searchMovies(String query) async {
  final response = await http.get(
    Uri.parse(baseUrl),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    final List movies = data['data'];

    final movieList = movies
        .map((movie) => Movie.fromJson(movie))
        .toList();

    return movieList.where((movie) {
      return movie.title
          .toLowerCase()
          .replaceAll(' ', '')
          .contains(
            query.toLowerCase().replaceAll(' ', ''),
          );
    }).toList();
  } else {
    throw Exception('Failed to search movies');
  }
}
}