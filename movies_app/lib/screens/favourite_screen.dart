import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stores/movie_provider.dart';

// This is the favourite movie screen userFavourite list of movies will be rendered
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Favourite Movies"),centerTitle: true,
        backgroundColor: Colors.yellow[400],),
      body: provider.favourites.isEmpty ? const Center(child: Text("ADD your favourite here, Navigate BACK"),) : ListView.separated(padding: const EdgeInsets.all(10),
        itemCount: provider.favourites.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 4,);
        },
        itemBuilder: (context, index) {
          final movie = provider.favourites[index];
          return ListTile(
            tileColor: Colors.yellow[100],
            leading: Image.network(movie.posterURL),
            title: Text(movie.title),
            trailing: Text("IMDB id:${movie.imdbId}"),
          );
        },
      ),
    );
  }
}
