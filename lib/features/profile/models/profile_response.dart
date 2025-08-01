import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: 'response')
  final ResponseInfo response;

  @JsonKey(name: 'data')
  final ProfileData data;

  const ProfileResponse({required this.response, required this.data});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
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
class ProfileData {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'photoUrl')
  final String? photoUrl;

  @JsonKey(name: 'token')
  final String token;

  const ProfileData({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.token,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}
