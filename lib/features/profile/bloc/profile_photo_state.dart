import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class ProfilePhotoState extends Equatable {
  final File? selectedImage;

  const ProfilePhotoState({this.selectedImage});

  @override
  List<Object?> get props => [selectedImage];
}

class ProfilePhotoInitial extends ProfilePhotoState {
  const ProfilePhotoInitial({File? selectedImage})
    : super(selectedImage: selectedImage);
}

class ProfilePhotoLoading extends ProfilePhotoState {
  const ProfilePhotoLoading({File? selectedImage})
    : super(selectedImage: selectedImage);
}

class ProfilePhotoSuccess extends ProfilePhotoState {
  final String message;

  const ProfilePhotoSuccess(this.message, {File? selectedImage})
    : super(selectedImage: selectedImage);

  @override
  List<Object?> get props => [message, selectedImage];
}

class ProfilePhotoError extends ProfilePhotoState {
  final String message;

  const ProfilePhotoError(this.message, {File? selectedImage})
    : super(selectedImage: selectedImage);

  @override
  List<Object?> get props => [message, selectedImage];
}
