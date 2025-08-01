import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/network_service.dart';
import 'profile_photo_event.dart';
import 'profile_photo_state.dart';

class ProfilePhotoBloc extends Bloc<ProfilePhotoEvent, ProfilePhotoState> {
  final UserService _userService = GetIt.instance<UserService>();
  final ImagePicker _picker = ImagePicker();

  ProfilePhotoBloc() : super(ProfilePhotoInitial()) {
    on<PickImageFromGallery>(_onPickImageFromGallery);
    on<ProfilePhotoSelected>(_onProfilePhotoSelected);
    on<ProfilePhotoUploaded>(_onProfilePhotoUploaded);
  }

  void _onPickImageFromGallery(
    PickImageFromGallery event,
    Emitter<ProfilePhotoState> emit,
  ) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 80,
      );

      if (image != null) {
        add(ProfilePhotoSelected(photoFile: File(image.path)));
      }
    } catch (e) {
      emit(
        ProfilePhotoError(
          'profile.photo.pick_error'.tr(),
          selectedImage: state.selectedImage,
        ),
      );
    }
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
