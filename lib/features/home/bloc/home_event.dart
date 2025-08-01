import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovies extends HomeEvent {
  const LoadMovies();
}

class LoadMoreMovies extends HomeEvent {
  final int page;

  const LoadMoreMovies({required this.page});

  @override
  List<Object?> get props => [page];
}

class RefreshMovies extends HomeEvent {
  const RefreshMovies();
}

class ToggleFavorite extends HomeEvent {
  final String movieId;

  const ToggleFavorite({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}
