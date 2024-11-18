import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stores/movie_provider.dart';
import 'details_screen.dart';
import 'favourite_screen.dart';

// This is the HOMESCREEN where the movie list will be rendered
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[400],
        title: const Text(
          "Movies List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Navigate to favorites screen
              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const FavouritesScreen(),
                                ),
                              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (query) {
                provider.searchMovies(query);
              },
              decoration: InputDecoration(
                hintText: 'Search movies...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.movies.isEmpty
                    ? const Center(
                        child: Text(
                          'No movies found.',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : GridView.builder(
                        itemCount: provider.movies.length,
                        padding: const EdgeInsets.all(10),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.6,
                        ),
                        itemBuilder: (context, index) {
                          final movie = provider.movies[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MovieDetailScreen(movie: movie),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              color: Colors.black,
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        child: SizedBox(
                                          height: MediaQuery.of(context).size.height / 3.3,
                                          width: double.infinity,
                                          child: Image.network(
                                            movie.posterURL,
                                            fit: BoxFit.fill,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset(
                                                "assets/images/jpg/error.jpg",
                                                fit: BoxFit.fill,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          movie.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
    provider.toggleFavourite(movie);
                                      },
                                      child:  CircleAvatar(
                                        backgroundColor: Colors.black,
                                        child: Icon(
                                          Icons.favorite_rounded,
                                          color: movie.isFavourite ? Colors.red : Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
