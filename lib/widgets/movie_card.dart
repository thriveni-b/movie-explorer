
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../screens/movie_details_screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      clipBehavior: Clip.antiAlias,

      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MovieDetailsScreen(
                  movie: movie,
                  
                );
              },
            ),
          );
        },

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Poster
            AspectRatio(
              aspectRatio: 0.75,

              child: Image.network(movie.poster,width: double.infinity,fit: BoxFit.cover,

                errorBuilder: (context,error,stackTrace,) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 40,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),

            // Title
            Padding(padding: const EdgeInsets.fromLTRB(12,10,12,6,),

              child: Text(
                movie.title,

                maxLines: 1,

                overflow: TextOverflow.ellipsis,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Year and Rating
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),

              child: Row(
                children: [
                  Text(
                    movie.year,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  const Spacer(),

                  const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  ),

                  const SizedBox(width: 5),

                  Text(
                    movie.rating.toStringAsFixed(1),

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

