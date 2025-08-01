import 'package:json_annotation/json_annotation.dart';
import '../../home/models/movie_model.dart';

part 'favorites_response.g.dart';

@JsonSerializable()
class FavoritesResponse {
  @JsonKey(name: 'response')
  final ResponseInfo response;

  @JsonKey(name: 'data')
  final FavoritesData data;

  const FavoritesResponse({required this.response, required this.data});

  factory FavoritesResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoritesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FavoritesResponseToJson(this);
}

@JsonSerializable()
class ResponseInfo {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'message')
  final String message;

  const ResponseInfo({required this.code, required this.message});

  factory ResponseInfo.fromJson(Map<String, dynamic> json) =>
      _$ResponseInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseInfoToJson(this);
}

@JsonSerializable()
class FavoritesData {
  @JsonKey(name: 'movies')
  final List<Movie> movies;

  const FavoritesData({required this.movies});

  factory FavoritesData.fromJson(Map<String, dynamic> json) =>
      _$FavoritesDataFromJson(json);
  Map<String, dynamic> toJson() => _$FavoritesDataToJson(this);
}
