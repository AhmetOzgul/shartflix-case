// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_photo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfilePhotoResponse _$ProfilePhotoResponseFromJson(
  Map<String, dynamic> json,
) => ProfilePhotoResponse(
  response: ResponseInfo.fromJson(json['response'] as Map<String, dynamic>),
  data: UserData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProfilePhotoResponseToJson(
  ProfilePhotoResponse instance,
) => <String, dynamic>{'response': instance.response, 'data': instance.data};

ResponseInfo _$ResponseInfoFromJson(Map<String, dynamic> json) => ResponseInfo(
  code: (json['code'] as num).toInt(),
  message: json['message'] as String,
);

Map<String, dynamic> _$ResponseInfoToJson(ResponseInfo instance) =>
    <String, dynamic>{'code': instance.code, 'message': instance.message};

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
  id: json['_id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  photoUrl: json['photoUrl'] as String,
);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'photoUrl': instance.photoUrl,
};
