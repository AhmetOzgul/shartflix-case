import 'package:json_annotation/json_annotation.dart';

part 'profile_photo_response.g.dart';

@JsonSerializable()
class ProfilePhotoResponse {
  final ResponseInfo response;
  final UserData data;

  ProfilePhotoResponse({required this.response, required this.data});

  factory ProfilePhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfilePhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilePhotoResponseToJson(this);
}

@JsonSerializable()
class ResponseInfo {
  final int code;
  final String message;

  ResponseInfo({required this.code, required this.message});

  factory ResponseInfo.fromJson(Map<String, dynamic> json) =>
      _$ResponseInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseInfoToJson(this);
}

@JsonSerializable()
class UserData {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;
  final String photoUrl;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
