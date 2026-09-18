import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../services/movie_service.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{

  late Future<List<Movie>> moviesFuture;

  @override
  void initState() {
    super.initState();
    moviesFuture = MovieService().fetchMovies();
  }


  @override
  Widget build(BuildContext context) {
    // final MovieService movieService = MovieService();

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 50, 49, 49),

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        toolbarHeight: 60,

        title: const Row(
          children: [
            Icon(
              Icons.movie_filter_rounded,
              color: Color(0xFF9C6BFF),
              size: 25,
            ),

            SizedBox(width: 10),

            Text(
              'Movie Explorer',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: FutureBuilder<List<Movie>>(
          future: moviesFuture,

          builder: (context, snapshot) {
            // Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // Error
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 60,
                        color: Theme.of(context).colorScheme.error,
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'Failed to load movies',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Something went wrong.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton.icon(
                        onPressed: () {
                           setState(() {
                              moviesFuture = MovieService().fetchMovies();
                       });
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            // No movies
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Icon(
                      Icons.movie_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),

                    SizedBox(height: 16),

                    Text(
                      'No movies found',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }

            final movies = snapshot.data!;

            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(16,16,16,24,),

              gridDelegate:
                  SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:
                    screenWidth > 600 ? 250 : 200,

                crossAxisSpacing: 14,
                mainAxisSpacing: 18,
                childAspectRatio:
                    screenWidth > 600 ? 0.58 : 0.55,
              ),

              itemCount: movies.length,

              itemBuilder: (context, index) {
                return MovieCard(
                  movie: movies[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

