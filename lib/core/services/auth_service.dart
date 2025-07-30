import '../constants/api_endpoints.dart';
import '../../features/login/model/login_response.dart';
import '../di/service_locator.dart';
import 'network_service.dart';

class AuthService {
  final NetworkService _networkService = getIt<NetworkService>();

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

      // Token'ı kaydet
      if (loginResponse.data?.token != null) {
        await _networkService.saveToken(loginResponse.data!.token);
      }

      return loginResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _networkService.post<Map<String, dynamic>>(
        ApiEndpoints.register,
        data: {'email': email, 'password': password, 'name': name},
      );

      final loginResponse = LoginResponse.fromJson(response.data!);

      // Token'ı kaydet
      if (loginResponse.data?.token != null) {
        await _networkService.saveToken(loginResponse.data!.token);
      }

      return loginResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> getProfile() async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        ApiEndpoints.profile,
      );

      return LoginResponse.fromJson(response.data!);
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> uploadPhoto({required String photo}) async {
    try {
      final response = await _networkService.post<Map<String, dynamic>>(
        ApiEndpoints.uploadPhoto,
        data: {'photo': photo},
      );
      return LoginResponse.fromJson(response.data!);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _networkService.getToken();
    return token != null && token.isNotEmpty;
  }
}
