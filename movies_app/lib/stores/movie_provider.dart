import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/movies_model.dart';
import '../utils/api/movie_api.dart';

// this is the main STORE class where the centralized variables and operations are done
class MovieProvider with ChangeNotifier {
  List<dynamic> _allMovies = []; // for storing the whole movie list
  List<dynamic> _movies = [];
  final List<dynamic> _favourites = [];
  bool _isLoading = false;
  String _currentQuery = ''; // for storing the current search query
  bool _isOffline = false; // for checking the device connected to internet or not

  List<dynamic> get movies => _movies;
  List<dynamic> get favourites => _favourites;
  bool get isLoading => _isLoading;
  bool get isOffline => _isOffline;

  final MovieApi _apiService = MovieApi(); // instance of movieapi

  // Check connectivity to determine offline/online mode
  Future<void> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _isOffline = connectivityResult == ConnectivityResult.none;
    notifyListeners();
  }

  // fetching movies via api call
  Future<void> fetchMovies() async {
    _isLoading = true;
    notifyListeners();
    
    _allMovies = (await _apiService.fetchMovies() ?? []);
    _movies = _allMovies;
    
    _isLoading = false;
    notifyListeners();
  }

  // this method help in searching the movie list
  Future<void> searchMovies(String query) async {
        _currentQuery = query; // Update the current query

    if (query.isEmpty) {
      _movies = _allMovies;
    } else {
      _movies = _allMovies
          .where((movie) =>
              movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // here the favourite bool is operated
  void toggleFavourite(MoviesModel movie) {
  final isFavourite = !movie.isFavourite;
  final updatedMovie = movie.copyWith(isFavourite: isFavourite);

  // Update the original movie list
  final movieIndex = _allMovies.indexWhere((m) => m.id == movie.id);
  if (movieIndex != -1) {
    _allMovies[movieIndex] = updatedMovie;
  }

  // Update the favourites list
  if (isFavourite) {
    _favourites.add(updatedMovie);
  } else {
    _favourites.removeWhere((m) => m.id == movie.id);
  }

  // Sync the filtered _movies list with updated _allMovies
    _movies = _allMovies
        .where((movie) => movie.title.toLowerCase().contains(_currentQuery.toLowerCase())) // Use current query
        .toList();

  notifyListeners();
}
}
