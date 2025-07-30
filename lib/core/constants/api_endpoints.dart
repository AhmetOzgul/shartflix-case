class ApiEndpoints {
  // USER
  static const String login = '/user/login';
  static const String profile = '/user/profile';
  static const String register = '/user/register';
  static const String uploadPhoto = '/user/upload_photo';

  // MOVIE
  static const String favorite = '/movie/favorite/{favoriteId}';
  static const String favorites = '/movie/favorites';
  static const String movieList = '/movie/list';
}
