import 'package:hive_flutter/hive_flutter.dart';

import '../../models/movies_model.dart';

// This is for the HIVE Database and operations using local db
class MovieDatabase {
  static Future<void> init() async {
    await Hive.initFlutter();
    // Register the MoviesModel adapter
    Hive.registerAdapter(MoviesModelAdapter());
    await Hive.openBox<MoviesModel>('movies');
  }

  static void saveMovies(List<MoviesModel> movies) {
    final box = Hive.box<MoviesModel>('movies');
    // Clear existing data and save new movies
    box.clear();
    for (var movie in movies) {
      box.add(movie);
    }
  }

  static List<MoviesModel> getMovies() {
    final box = Hive.box<MoviesModel>('movies');
    return box.values.toList();
  }

  static void updateFavourite(int movieId, bool isFavourite) {
    final box = Hive.box<MoviesModel>('movies');
    final index = box.values.toList().indexWhere((movie) => movie.id == movieId);

    if (index != -1) {
      final movie = box.getAt(index);
      if (movie != null) {
        final updatedMovie = movie.copyWith(isFavourite: isFavourite);
        box.putAt(index, updatedMovie);
      }
    }
  }
}
