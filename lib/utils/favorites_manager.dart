import '../models/movie.dart';
class FavoritesManager {
  static final List<Movie> favorites = [];

  static void addToFavorites(Movie movie) {
    if (!favorites.any((item) => item.id == movie.id)) {
      favorites.add(movie);
    }
  }

  static void removeFromFavorites(Movie movie) {
   favorites.remove(movie);
  //  favorites.removeWhere((item)=>item.id == movie.id);
  }
}