import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../models/movies_model.dart';
import '../db/movie_database.dart';

// This file is mainly for API call for the desired API call
class MovieApi {
  // main url
  final String baseUrl = "https://api.sampleapis.com";
  final String path1 = "/movies";
  final String animationApi = "/animation";

  Future<dynamic> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$path1$animationApi'));
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body) as List;

       List<MoviesModel> moviesList = decodedData.map((e) => MoviesModel.fromJson(e),).toList();

       // Save movies in Hive
        MovieDatabase.saveMovies(moviesList);
        
        log('Movies List: $moviesList');
        return moviesList;
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      log('############### ERROR RESPOSE #########');
      log(e.toString());

      return [];
    } finally {
      log('Fetch movies operation completed');
    }
  }
}
