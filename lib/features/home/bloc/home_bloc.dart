import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../core/services/movie_service.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieService _movieService = GetIt.instance<MovieService>();

  HomeBloc() : super(HomeInitial()) {
    on<LoadMovies>(_onLoadMovies);
    on<LoadMoreMovies>(_onLoadMoreMovies);
    on<RefreshMovies>(_onRefreshMovies);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadMovies(LoadMovies event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final response = await _movieService.getMovies(page: 1);
      emit(
        HomeLoaded(
          movies: response.movies,
          currentPage: response.pagination.currentPage,
          maxPage: response.pagination.maxPage,
          hasReachedMax:
              response.pagination.currentPage >= response.pagination.maxPage,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onLoadMoreMovies(
    LoadMoreMovies event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is HomeLoaded && !currentState.hasReachedMax) {
      try {
        final response = await _movieService.getMovies(page: event.page);
        final updatedMovies = [...currentState.movies, ...response.movies];
        emit(
          HomeLoaded(
            movies: updatedMovies,
            currentPage: response.pagination.currentPage,
            maxPage: response.pagination.maxPage,
            hasReachedMax:
                response.pagination.currentPage >= response.pagination.maxPage,
          ),
        );
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    }
  }

  Future<void> _onRefreshMovies(
    RefreshMovies event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final response = await _movieService.getMovies(page: 1);
      emit(
        HomeLoaded(
          movies: response.movies,
          currentPage: response.pagination.currentPage,
          maxPage: response.pagination.maxPage,
          hasReachedMax:
              response.pagination.currentPage >= response.pagination.maxPage,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(currentState.copyWith(isFavoriteLoading: true));

      try {
        final response = await _movieService.toggleFavorite(
          movieId: event.movieId,
        );

        final updatedMovies = currentState.movies.map((movie) {
          if (movie.id == event.movieId) {
            return response.data.movie;
          }
          return movie;
        }).toList();

        emit(
          HomeLoaded(
            movies: updatedMovies,
            currentPage: currentState.currentPage,
            maxPage: currentState.maxPage,
            hasReachedMax: currentState.hasReachedMax,
            isFavoriteLoading: false,
          ),
        );
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    }
  }
}
