import 'dart:io';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class ProfilePhotoEvent extends Equatable {
  const ProfilePhotoEvent();

  @override
  List<Object?> get props => [];
}

class PickImageFromGallery extends ProfilePhotoEvent {}

class ProfilePhotoSelected extends ProfilePhotoEvent {
  final File photoFile;

  const ProfilePhotoSelected({required this.photoFile});

  @override
  List<Object?> get props => [photoFile];
}

class ProfilePhotoUploaded extends ProfilePhotoEvent {
  final File photoFile;
  final BuildContext context;

  const ProfilePhotoUploaded({required this.photoFile, required this.context});

  @override
  List<Object?> get props => [photoFile, context];
}
