import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movies_model.g.dart';

// This is the main model class where we use to map the api data and hive data
@JsonSerializable()
@HiveType(typeId: 0)
class MoviesModel {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? posterURL;
  
  @HiveField(3)
  final String? imdbId;
  
  @HiveField(4)
  final bool isFavourite;

  MoviesModel({
    this.id,
    this.title,
    this.posterURL,
    this.imdbId,
    this.isFavourite = false,
  });

  /// Factory constructor to create a `Movie` instance from a JSON map.
  factory MoviesModel.fromJson(Map<String, dynamic> json) => _$MoviesModelFromJson(json);

  /// Method to convert a `Movie` instance to a JSON map.
  Map<String, dynamic> toJson() => _$MoviesModelToJson(this);

  /// CopyWith method to create a new Movie instance with updated values.
  MoviesModel copyWith({
    int? id,
    String? title,
    String? posterURL,
    String? imdbId,
      bool? isFavourite,

  }) {
    return MoviesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      posterURL: posterURL ?? this.posterURL,
      imdbId: imdbId ?? this.imdbId,
          isFavourite: isFavourite ?? this.isFavourite,

    );
  }
}
