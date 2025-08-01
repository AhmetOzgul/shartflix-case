// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
  id: json['id'] as String,
  title: json['Title'] as String,
  year: json['Year'] as String,
  rated: json['Rated'] as String,
  released: json['Released'] as String,
  runtime: json['Runtime'] as String,
  genre: json['Genre'] as String,
  director: json['Director'] as String,
  writer: json['Writer'] as String,
  actors: json['Actors'] as String,
  plot: json['Plot'] as String,
  language: json['Language'] as String,
  country: json['Country'] as String,
  awards: json['Awards'] as String,
  poster: json['Poster'] as String,
  metascore: json['Metascore'] as String,
  imdbRating: json['imdbRating'] as String,
  imdbVotes: json['imdbVotes'] as String,
  imdbID: json['imdbID'] as String,
  type: json['Type'] as String,
  response: json['Response'] as String,
  images: (json['Images'] as List<dynamic>).map((e) => e as String).toList(),
  comingSoon: json['ComingSoon'] as bool,
  isFavorite: json['isFavorite'] as bool,
);

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
  'id': instance.id,
  'Title': instance.title,
  'Year': instance.year,
  'Rated': instance.rated,
  'Released': instance.released,
  'Runtime': instance.runtime,
  'Genre': instance.genre,
  'Director': instance.director,
  'Writer': instance.writer,
  'Actors': instance.actors,
  'Plot': instance.plot,
  'Language': instance.language,
  'Country': instance.country,
  'Awards': instance.awards,
  'Poster': instance.poster,
  'Metascore': instance.metascore,
  'imdbRating': instance.imdbRating,
  'imdbVotes': instance.imdbVotes,
  'imdbID': instance.imdbID,
  'Type': instance.type,
  'Response': instance.response,
  'Images': instance.images,
  'ComingSoon': instance.comingSoon,
  'isFavorite': instance.isFavorite,
};

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  totalCount: (json['totalCount'] as num).toInt(),
  perPage: (json['perPage'] as num).toInt(),
  maxPage: (json['maxPage'] as num).toInt(),
  currentPage: (json['currentPage'] as num).toInt(),
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'perPage': instance.perPage,
      'maxPage': instance.maxPage,
      'currentPage': instance.currentPage,
    };

MovieListResponse _$MovieListResponseFromJson(Map<String, dynamic> json) =>
    MovieListResponse(
      movies: (json['movies'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: Pagination.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$MovieListResponseToJson(MovieListResponse instance) =>
    <String, dynamic>{
      'movies': instance.movies,
      'pagination': instance.pagination,
    };
