class Movie {
  final String id;
  final String title;
  final String year;
  final String plot;
  final String poster;
  final String released;
  final String genre;
  final String actors;
  final double rating;


  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.plot,
    required this.poster,
    required this.released,
    required this.genre,
    required this.actors,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Unknown',
      year: json['year'] ?? '',
      plot: json['plot'] ?? 'No description available',
      poster: json['poster'] ?? '',
      released: json['released'] ?? '',
      actors:json['actors'] ?? '',
      genre: json['genre'] ?? '',
      rating: double.tryParse(json['imdbRating'] ?? '0') ?? 0.0,
    );
  }
}