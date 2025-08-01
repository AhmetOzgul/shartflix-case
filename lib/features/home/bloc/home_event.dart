import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovies extends HomeEvent {
  final int page;

  const LoadMovies({this.page = 1});

  @override
  List<Object?> get props => [page];
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
