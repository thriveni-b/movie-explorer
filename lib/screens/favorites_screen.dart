
import 'package:flutter/material.dart';
import '../utils/favorites_manager.dart';
import '../models/movie.dart';

class FavoritesScreen extends StatefulWidget {

  const FavoritesScreen({
    super.key
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {

    final List<Movie> favorites = FavoritesManager.favorites;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 50, 49, 49),

      appBar: AppBar(
        backgroundColor: const Color(0xFF171321),
        foregroundColor: Colors.white,

        title: const Text(
          'Favourites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorite movies',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),

              itemCount:favorites.length,

              itemBuilder: (context, index) {
                final movie = favorites[index];

                return Card(
                  color: Colors.black,

                  margin: const EdgeInsets.only(
                    bottom: 12,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),

                  clipBehavior: Clip.antiAlias,

                  child: SizedBox(
                    height: 200,

                    child: Row(
                      children: [
                        // Movie poster
                        SizedBox(
                          width: 150,
                          height: 200,

                          child: Image.network(
                            movie.poster,

                            fit: BoxFit.cover,

                            errorBuilder: (context,error, stackTrace,) {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 15),

                        // Movie details
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),

                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [
                                Text(
                                  movie.title,

                                  maxLines: 2,

                                  overflow:TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Text(
                                  movie.year,

                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),

                                    const SizedBox(width: 5),

                                    Text(
                                      movie.rating.toStringAsFixed(1),

                                      style:
                                          const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),

                                const Spacer(),

                                // Remove button
                                Align(
                                  alignment:
                                      Alignment.bottomRight,

                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),

                                    onPressed: () {
                                      setState(() {
                                        
                                       FavoritesManager.
                                       removeFromFavorites(
                                        movie
                                      );
                                      });
                                     
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Movie Removed from favorites')));

                                      
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

