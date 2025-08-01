import 'package:equatable/equatable.dart';
import '../models/movie_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<Movie> movies;
  final int currentPage;
  final int maxPage;
  final bool hasReachedMax;

  const HomeLoaded({
    required this.movies,
    required this.currentPage,
    required this.maxPage,
    this.hasReachedMax = false,
  });

  HomeLoaded copyWith({
    List<Movie>? movies,
    int? currentPage,
    int? maxPage,
    bool? hasReachedMax,
  }) {
    return HomeLoaded(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      maxPage: maxPage ?? this.maxPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [movies, currentPage, maxPage, hasReachedMax];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
