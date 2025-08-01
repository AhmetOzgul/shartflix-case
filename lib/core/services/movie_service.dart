import 'package:get_it/get_it.dart';
import '../constants/api_endpoints.dart';
import '../../features/home/models/movie_model.dart';
import '../../features/home/models/favorite_response.dart';
import '../../features/profile/models/favorites_response.dart' as profile;
import 'network_service.dart';

class MovieService {
  final NetworkService _networkService = GetIt.instance<NetworkService>();

  Future<MovieListResponse> getMovies({required int page}) async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        '/movie/list',
        queryParameters: {'page': page},
      );
      final movieListResponse = MovieListResponse.fromJson(response.data!);

      if (response.data!['response']['code'] != 200) {
        throw BadRequestException(response.data!['response']['message']);
      }

      return movieListResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<FavoriteResponse> toggleFavorite({required String movieId}) async {
    try {
      final response = await _networkService.post<Map<String, dynamic>>(
        '/movie/favorite/$movieId',
      );

      final favoriteResponse = FavoriteResponse.fromJson(response.data!);

      return favoriteResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<profile.FavoritesResponse> getFavorites() async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        ApiEndpoints.favorites,
      );

      if (response.data!['response']['code'] != 200) {
        throw BadRequestException(response.data!['response']['message']);
      }

      final moviesList = response.data!['data'] as List<dynamic>;
      final movies = moviesList
          .map((movieJson) => Movie.fromJson(movieJson as Map<String, dynamic>))
          .toList();

      final favoritesData = profile.FavoritesData(movies: movies);
      final responseInfo = profile.ResponseInfo(
        code: response.data!['response']['code'],
        message: response.data!['response']['message'],
      );

      return profile.FavoritesResponse(
        response: responseInfo,
        data: favoritesData,
      );
    } catch (e) {
      rethrow;
    }
  }
}
