import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/movie_service.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserService _userService = GetIt.instance<UserService>();
  final MovieService _movieService = GetIt.instance<MovieService>();

  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<RefreshProfile>(_onRefreshProfile);
    on<LoadFavorites>(_onLoadFavorites);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final response = await _userService.getProfile();
      emit(ProfileLoaded(profileData: response.data));
    } catch (e) {
      emit(const ProfileError('Profil yüklenirken bir hata oluştu'));
    }
  }

  Future<void> _onRefreshProfile(
    RefreshProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      final response = await _userService.getProfile();
      emit(ProfileLoaded(profileData: response.data));
    } catch (e) {
      emit(const ProfileError('Profil yenilenirken bir hata oluştu'));
    }
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      final currentState = state;

      if (currentState is! ProfileLoaded) {
        final profileResponse = await _userService.getProfile();
        final profileData = profileResponse.data;

        final favoritesResponse = await _movieService.getFavorites();
        emit(
          ProfileLoaded(
            profileData: profileData,
            favorites: favoritesResponse.data.movies,
          ),
        );
      } else {
        final favoritesResponse = await _movieService.getFavorites();
        emit(currentState.copyWith(favorites: favoritesResponse.data.movies));
      }
    } catch (e) {}
  }
}
