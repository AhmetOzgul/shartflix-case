import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../core/services/movie_service.dart';
import '../../../core/services/network_service.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieService _movieService = GetIt.instance<MovieService>();

  HomeBloc() : super(const HomeInitial()) {
    on<LoadMovies>(_onLoadMovies);
    on<LoadMoreMovies>(_onLoadMoreMovies);
    on<RefreshMovies>(_onRefreshMovies);
  }

  void _onLoadMovies(LoadMovies event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());

    try {
      final response = await _movieService.getMovies(page: event.page);
      emit(
        HomeLoaded(
          movies: response.movies,
          currentPage: response.pagination.currentPage,
          maxPage: response.pagination.maxPage,
          hasReachedMax:
              response.pagination.currentPage >= response.pagination.maxPage,
        ),
      );
    } on BadRequestException catch (e) {
      emit(HomeError(e.message));
    } on NetworkException catch (e) {
      emit(HomeError(e.message));
    } catch (e) {
      emit(HomeError('Bilinmeyen bir hata oluştu'));
    }
  }

  void _onLoadMoreMovies(LoadMoreMovies event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;

      if (currentState.hasReachedMax) {
        return;
      }

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
      } on BadRequestException catch (e) {
        emit(HomeError(e.message));
      } on NetworkException catch (e) {
        emit(HomeError(e.message));
      } catch (e) {
        emit(HomeError('Bilinmeyen bir hata oluştu'));
      }
    }
  }

  void _onRefreshMovies(RefreshMovies event, Emitter<HomeState> emit) async {
    add(const LoadMovies(page: 1));
  }
}
