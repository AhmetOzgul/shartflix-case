import '../constants/api_endpoints.dart';
import '../di/service_locator.dart';
import 'network_service.dart';

class MovieService {
  final NetworkService _networkService = getIt<NetworkService>();

  // Favori film ekleme
  Future<Map<String, dynamic>> addFavorite({required String movieId}) async {
    try {
      final response = await _networkService.post<Map<String, dynamic>>(
        ApiEndpoints.favorite.replaceAll('{favoriteId}', movieId),
      );
      return response.data ?? {};
    } catch (e) {
      rethrow;
    }
  }

  // Film listesi
  Future<List<Map<String, dynamic>>> getMovieList() async {
    try {
      final response = await _networkService.get<List<Map<String, dynamic>>>(
        ApiEndpoints.movieList,
      );
      return response.data ?? [];
    } catch (e) {
      rethrow;
    }
  }

  // Favori filmleri listeleme
  Future<List<Map<String, dynamic>>> getFavorites() async {
    try {
      final response = await _networkService.get<List<Map<String, dynamic>>>(
        ApiEndpoints.favorites,
      );
      return response.data ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
