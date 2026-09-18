import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../services/movie_service.dart';
import '../widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {

  const SearchScreen({
    super.key
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  final MovieService movieService = MovieService();

  List<Movie> searchResults = [];
  bool hasSearched = false;
  bool isLoading = false;
  String? errorMessage;

  Future<void> searchMovies() async {
    if (searchController.text.trim().isEmpty) {
      setState(() {
        errorMessage = 'Please enter a movie name';
        searchResults = [];
        hasSearched=false;
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
      hasSearched=true;
    });

    try {
      final results = await movieService.searchMovies(
        searchController.text.trim(),
      );

      setState(() {
        searchResults = results;
        isLoading = false;
      });
    }  
    
    catch (e) {
    setState(() {
    isLoading = false;
    errorMessage = e.toString();
    searchResults = [];
  });
}
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 50, 49, 49),
      appBar: AppBar(
       backgroundColor: Colors.black,
        title: const Text('Search Movies',style: TextStyle(color: Colors.white),),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Enter movie name',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(width: 20) ),
                    ),
                    onSubmitted: (text) {
                      searchMovies();
                    },
                  ),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: searchMovies,
                  child: const Text('Search'),
                ),
              ],
            ),

            const SizedBox(height: 20), 

            if (isLoading)
              const CircularProgressIndicator(),

            if (errorMessage != null && !isLoading)
              Text(errorMessage!,style: const TextStyle(color: Colors.white)),

           if (!isLoading && errorMessage == null && hasSearched && searchResults.isEmpty)
  const Text(
    'No movie found',
    style: TextStyle(color: Colors.white),
  ),

            if (!isLoading && searchResults.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  gridDelegate:SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:
                    screenWidth > 600 ? 250 : 200,

                crossAxisSpacing: 14,
                mainAxisSpacing: 18,

                childAspectRatio:
                    screenWidth > 600 ? 0.58 : 0.55,
              ),

                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      movie: searchResults[index],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

