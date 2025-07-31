import 'package:get_it/get_it.dart';
import '../services/network_service.dart';
import '../services/user_service.dart';
import '../services/movie_service.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<NetworkService>(() => NetworkService());

  getIt.registerLazySingleton<UserService>(() => UserService());
  getIt.registerLazySingleton<MovieService>(() => MovieService());
}
