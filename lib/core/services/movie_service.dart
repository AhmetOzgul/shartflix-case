import 'package:get_it/get_it.dart';
import '../../features/home/models/movie_model.dart';
import '../../features/home/models/favorite_response.dart';
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
}
