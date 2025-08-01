// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritesResponse _$FavoritesResponseFromJson(Map<String, dynamic> json) =>
    FavoritesResponse(
      response: ResponseInfo.fromJson(json['response'] as Map<String, dynamic>),
      data: FavoritesData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoritesResponseToJson(FavoritesResponse instance) =>
    <String, dynamic>{'response': instance.response, 'data': instance.data};

ResponseInfo _$ResponseInfoFromJson(Map<String, dynamic> json) => ResponseInfo(
  code: (json['code'] as num).toInt(),
  message: json['message'] as String,
);

Map<String, dynamic> _$ResponseInfoToJson(ResponseInfo instance) =>
    <String, dynamic>{'code': instance.code, 'message': instance.message};

FavoritesData _$FavoritesDataFromJson(Map<String, dynamic> json) =>
    FavoritesData(
      movies: (json['movies'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoritesDataToJson(FavoritesData instance) =>
    <String, dynamic>{'movies': instance.movies};
