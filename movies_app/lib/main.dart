import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'stores/movie_provider.dart';
import 'utils/db/movie_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MovieDatabase.init(); // Initialize Hive Database
  runApp(
    // movie app providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            final movieProvider = MovieProvider();
            movieProvider.fetchMovies(); // Trigger API call here
            return movieProvider;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
