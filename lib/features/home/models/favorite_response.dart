import 'package:json_annotation/json_annotation.dart';
import 'movie_model.dart';

part 'favorite_response.g.dart';

@JsonSerializable()
class FavoriteResponse {
  @JsonKey(name: 'response')
  final ResponseInfo response;

  @JsonKey(name: 'data')
  final FavoriteData data;

  const FavoriteResponse({required this.response, required this.data});

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteResponseToJson(this);
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
class FavoriteData {
  @JsonKey(name: 'movie')
  final Movie movie;

  @JsonKey(name: 'action')
  final String action;

  const FavoriteData({required this.movie, required this.action});

  factory FavoriteData.fromJson(Map<String, dynamic> json) =>
      _$FavoriteDataFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteDataToJson(this);
}
