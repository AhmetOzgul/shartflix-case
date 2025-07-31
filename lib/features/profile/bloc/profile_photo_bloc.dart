import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import '../../../core/services/user_service.dart';
import '../../../core/services/network_service.dart';
import 'profile_photo_event.dart';
import 'profile_photo_state.dart';

class ProfilePhotoBloc extends Bloc<ProfilePhotoEvent, ProfilePhotoState> {
  final UserService _userService = GetIt.instance<UserService>();

  ProfilePhotoBloc() : super(ProfilePhotoInitial()) {
    on<ProfilePhotoSelected>(_onProfilePhotoSelected);
    on<ProfilePhotoUploaded>(_onProfilePhotoUploaded);
  }

  void _onProfilePhotoSelected(
    ProfilePhotoSelected event,
    Emitter<ProfilePhotoState> emit,
  ) {
    emit(ProfilePhotoInitial(selectedImage: event.photoFile));
  }

  void _onProfilePhotoUploaded(
    ProfilePhotoUploaded event,
    Emitter<ProfilePhotoState> emit,
  ) async {
    emit(ProfilePhotoLoading(selectedImage: state.selectedImage));

    try {
      final response = await _userService.uploadProfilePhoto(
        photoFile: event.photoFile,
      );

      if (response.response.code == 200) {
        emit(
          ProfilePhotoSuccess(
            'profile.photo.upload_success'.tr(),
            selectedImage: state.selectedImage,
          ),
        );
      } else {
        emit(
          ProfilePhotoError(
            response.response.message,
            selectedImage: state.selectedImage,
          ),
        );
      }
    } on BadRequestException catch (e) {
      emit(ProfilePhotoError(e.message, selectedImage: state.selectedImage));
    } on NetworkException catch (e) {
      emit(ProfilePhotoError(e.message, selectedImage: state.selectedImage));
    } catch (e) {
      emit(
        ProfilePhotoError(
          'profile.photo.upload_error'.tr(),
          selectedImage: state.selectedImage,
        ),
      );
    }
  }
}
