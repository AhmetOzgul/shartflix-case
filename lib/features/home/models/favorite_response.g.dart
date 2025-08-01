// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteResponse _$FavoriteResponseFromJson(Map<String, dynamic> json) =>
    FavoriteResponse(
      response: ResponseInfo.fromJson(json['response'] as Map<String, dynamic>),
      data: FavoriteData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteResponseToJson(FavoriteResponse instance) =>
    <String, dynamic>{'response': instance.response, 'data': instance.data};

ResponseInfo _$ResponseInfoFromJson(Map<String, dynamic> json) => ResponseInfo(
  code: (json['code'] as num).toInt(),
  message: json['message'] as String,
);

Map<String, dynamic> _$ResponseInfoToJson(ResponseInfo instance) =>
    <String, dynamic>{'code': instance.code, 'message': instance.message};

FavoriteData _$FavoriteDataFromJson(Map<String, dynamic> json) => FavoriteData(
  movie: Movie.fromJson(json['movie'] as Map<String, dynamic>),
  action: json['action'] as String,
);

Map<String, dynamic> _$FavoriteDataToJson(FavoriteData instance) =>
    <String, dynamic>{'movie': instance.movie, 'action': instance.action};
