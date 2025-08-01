import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'Title')
  final String title;

  @JsonKey(name: 'Year')
  final String year;

  @JsonKey(name: 'Rated')
  final String rated;

  @JsonKey(name: 'Released')
  final String released;

  @JsonKey(name: 'Runtime')
  final String runtime;

  @JsonKey(name: 'Genre')
  final String genre;

  @JsonKey(name: 'Director')
  final String director;

  @JsonKey(name: 'Writer')
  final String writer;

  @JsonKey(name: 'Actors')
  final String actors;

  @JsonKey(name: 'Plot')
  final String plot;

  @JsonKey(name: 'Language')
  final String language;

  @JsonKey(name: 'Country')
  final String country;

  @JsonKey(name: 'Awards')
  final String awards;

  @JsonKey(name: 'Poster')
  final String poster;

  @JsonKey(name: 'Metascore')
  final String metascore;

  @JsonKey(name: 'imdbRating')
  final String imdbRating;

  @JsonKey(name: 'imdbVotes')
  final String imdbVotes;

  @JsonKey(name: 'imdbID')
  final String imdbID;

  @JsonKey(name: 'Type')
  final String type;

  @JsonKey(name: 'Response')
  final String response;

  @JsonKey(name: 'Images')
  final List<String> images;

  @JsonKey(name: 'ComingSoon')
  final bool comingSoon;

  @JsonKey(name: 'isFavorite')
  final bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbID,
    required this.type,
    required this.response,
    required this.images,
    required this.comingSoon,
    required this.isFavorite,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    String posterUrl = json['Poster'] ?? '';
    if (posterUrl.startsWith('http://')) {
      posterUrl = posterUrl.replaceFirst('http://', 'https://');
    }

    // API'de _id field'ı var, id field'ı yok
    String movieId = json['_id'] ?? json['id'] ?? '';

    return Movie(
      id: movieId,
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      rated: json['Rated'] ?? '',
      released: json['Released'] ?? '',
      runtime: json['Runtime'] ?? '',
      genre: json['Genre'] ?? '',
      director: json['Director'] ?? '',
      writer: json['Writer'] ?? '',
      actors: json['Actors'] ?? '',
      plot: json['Plot'] ?? '',
      language: json['Language'] ?? '',
      country: json['Country'] ?? '',
      awards: json['Awards'] ?? '',
      poster: posterUrl,
      metascore: json['Metascore'] ?? '',
      imdbRating: json['imdbRating'] ?? '',
      imdbVotes: json['imdbVotes'] ?? '',
      imdbID: json['imdbID'] ?? '',
      type: json['Type'] ?? '',
      response: json['Response'] ?? '',
      images: List<String>.from(json['Images'] ?? []),
      comingSoon: json['ComingSoon'] ?? false,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: 'totalCount')
  final int totalCount;

  @JsonKey(name: 'perPage')
  final int perPage;

  @JsonKey(name: 'maxPage')
  final int maxPage;

  @JsonKey(name: 'currentPage')
  final int currentPage;

  Pagination({
    required this.totalCount,
    required this.perPage,
    required this.maxPage,
    required this.currentPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable()
class MovieListResponse {
  @JsonKey(name: 'movies')
  final List<Movie> movies;

  @JsonKey(name: 'pagination')
  final Pagination pagination;

  MovieListResponse({required this.movies, required this.pagination});

  factory MovieListResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return MovieListResponse(
      movies: (data['movies'] as List<dynamic>)
          .map((movie) => Movie.fromJson(movie as Map<String, dynamic>))
          .toList(),
      pagination: Pagination.fromJson(
        data['pagination'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() => _$MovieListResponseToJson(this);
}
