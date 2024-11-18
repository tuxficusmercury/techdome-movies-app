# movies_app(Movie Browser App)

Movie Browser App is a cross-platform mobile application built with Flutter that allows users to browse, search, and save their favorite movies using a movie API. The app supports offline functionality with local caching and provides features such as advanced search filters, a favourites section, and a smooth user experience with an animated splash screen(WORK IN PROGRESS).

## Environment Prerequisites
- Flutter Version: <kbd>3.24.0</kbd>
- Dart SDK Version: <kbd>3.5.0</kbd>
- git clone https://github.com/tuxficusmercury/techdome-movies-app.git

## Build command via cmd
```
flutter build apk
```

## App Skeleton
movies-app/
├── lib/
│   ├── main.dart              # Entry point of the application
│   ├── screens/               # Contains all the app screens
│   │   ├── home_screen.dart   # Home Screen for browsing movies
│   │   ├── details_screen.dart# Movie details screen
│   │   ├── favourites_screen.dart # Favourites screen
│   ├── utils/              # Contains API and database services
│   │   ├── api
│   │   │   ├── movie_api_service.dart # Handles API calls
│   │   ├── db
│   │   │   ├── movie_database.dart    # Handles local storage
│   ├── providers/             # State management using Provider
│   │   ├── movie_provider.dart # Central state management
│
└── pubspec.yaml               # Dependencies and project metadata


## App Architecture-
lib is the base directory
- **models**
    - **movies_model.dart** - here we map the sample api data the pojos
                            - it has a .g.dart file which is auto generated using the below command
                            - flutter pub run build runner build
                            - this is possible with json_annotation: ^4.9.0
                                                    build_runner: ^2.4.13
                                                    json_serializable: ^6.8.0
                            - these packages help me to seemlessly write the pojos

- **screens**
    - **details_screen.dart** - here you can see the details of a movie and navigate to favourites page and add/remove to favourites
    - **favourite_screen.dart** - here you can view the detailed list of favourite movie selected by the user
    - **home_screen.dart** - this is the heart of our app. Where the main functionalities can be seen, done and navigate through

- **stores**
    - **movie_provider.dart** - Here the whole apps data is maintained and operated like the variable declarations, assigning the api data, add/remove favourite movie to a list all through notifyListeners the key player in the provider package

- **utils**
    - **api**
        - **movie_api.dart** - Here we hit the server with the desired api to get the desired data where we further operate on

    - **db**
        - **movie_database.dart** - Here the local storage within the user mobile functions are invoked and operated on (WORK IN PROGRESS)

## General Flow of the APP-
Features in Detail
    Home Screen
        Displays a list of movies fetched from the API.
        Includes a search bar for real-time movie searches.
        Features a filter option for advanced search (e.g., filter by year or rating).

    Movie Details Screen
        Displays detailed information about the selected movie, including:
            Title
            Poster
            IMDb ID
            Option to add or remove the movie from the favourites list.
    
    Favourites Screen
        Displays a list of movies marked as favourites.
    Data is cached locally for offline access.(work in progress)
    
    Offline Support(work in progress)
        Movies and favourites are cached locally using Hive.
        When offline, cached data is displayed, and changes (e.g., adding favourites) are synchronized with the backend upon reconnection.
    
    Splash Screen(work in progress)
        Animated splash screen displayed when the app launches.
        Features a fade-in animation of the app logo.
    
    Test Credentials
        No credentials are required to test the app.
    
    Known Issues
        Ensure the API endpoint is live and accessible.
        Test performance with a large movie dataset.