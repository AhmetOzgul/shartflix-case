import 'package:equatable/equatable.dart';
import '../../models/profile_response.dart';
import '../../../home/models/movie_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileData profileData;
  final List<Movie>? favorites;

  const ProfileLoaded({required this.profileData, this.favorites});

  ProfileLoaded copyWith({ProfileData? profileData, List<Movie>? favorites}) {
    return ProfileLoaded(
      profileData: profileData ?? this.profileData,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  List<Object?> get props => [profileData, favorites];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
