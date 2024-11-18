import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stores/movie_provider.dart';
import 'favourite_screen.dart';

// This is the movie detail movie screen with extra information
class MovieDetailScreen extends StatelessWidget {
  final dynamic movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        centerTitle: true,
        backgroundColor: Colors.yellow[400],
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
          SizedBox(
            width: double.infinity,
            child: Image.network(
              movie.posterURL,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/jpg/error.jpg",
                );
              },
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(movie.title, style: const TextStyle(fontSize: 24)),
          const SizedBox(
            height: 4,
          ),
          Text("IMDb ID: ${movie.imdbId}"),
           ElevatedButton(
            onPressed: () {
              Provider.of<MovieProvider>(context, listen: false)
                  .toggleFavourite(movie);
            },
            child: Consumer<MovieProvider>(
              builder: (context, provider, child) {
                    final movieProvider = provider.movies.firstWhere((m) => m.id == movie.id);

                return Text(
                  movieProvider.isFavourite ? "Remove from Favourites" : "Add to Favourites",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
