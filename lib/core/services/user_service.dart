import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shartflix/features/login/models/login_response.dart';
import 'package:shartflix/features/profile/models/profile_photo_response.dart';
import 'package:shartflix/features/profile/models/profile_response.dart';
import '../constants/api_endpoints.dart';
import '../../features/register/model/register_response.dart';
import 'network_service.dart';

class UserService {
  final NetworkService _networkService = GetIt.instance<NetworkService>();

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _networkService.post<Map<String, dynamic>>(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      final loginResponse = LoginResponse.fromJson(response.data!);

      if (loginResponse.response.code != 200) {
        if (loginResponse.response.code == 400 &&
            loginResponse.response.message == 'INVALID_CREDENTIALS') {
          throw BadRequestException('INVALID_CREDENTIALS');
        }
        throw BadRequestException(loginResponse.response.message);
      }

      // Token'ı kaydet
      await _saveToken(loginResponse.data!.token);

      return loginResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<RegisterResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _networkService.post<Map<String, dynamic>>(
        ApiEndpoints.register,
        data: {'name': name, 'email': email, 'password': password},
      );

      final registerResponse = RegisterResponse.fromJson(response.data!);

      if (registerResponse.response.code != 200) {
        if (registerResponse.response.code == 400 &&
            registerResponse.response.message == 'USER_EXISTS') {
          throw BadRequestException('USER_EXISTS');
        }
        throw BadRequestException(registerResponse.response.message);
      }

      // Token'ı kaydet
      await _saveToken(registerResponse.data!.token);

      return registerResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProfilePhotoResponse> uploadProfilePhoto({
    required File photoFile,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          photoFile.path,
          filename: photoFile.path.split('/').last,
        ),
      });

      final response = await _networkService.post<Map<String, dynamic>>(
        ApiEndpoints.uploadPhoto,
        data: formData,
      );

      final profilePhotoResponse = ProfilePhotoResponse.fromJson(
        response.data!,
      );

      if (profilePhotoResponse.response.code != 200) {
        throw BadRequestException(profilePhotoResponse.response.message);
      }

      return profilePhotoResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProfileResponse> getProfile() async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        ApiEndpoints.profile,
      );

      final profileResponse = ProfileResponse.fromJson(response.data!);

      if (response.data!['response']['code'] != 200) {
        throw BadRequestException(response.data!['response']['message']);
      }

      return profileResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _networkService.getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await _networkService.clearToken();
  }

  Future<void> _saveToken(String token) async {
    await _networkService.saveToken(token);
  }
}
