import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/shared/widgets/auth_header.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../core/router/routes.dart';
import '../bloc/upload_photo/profile_photo_bloc.dart';
import '../bloc/upload_photo/profile_photo_event.dart';
import '../bloc/upload_photo/profile_photo_state.dart';
import '../widgets/photo_selection_button.dart';

class UploadPhotoPage extends StatefulWidget {
  final bool fromProfile;

  const UploadPhotoPage({super.key, this.fromProfile = false});

  @override
  State<UploadPhotoPage> createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePhotoBloc(),
      child: BlocListener<ProfilePhotoBloc, ProfilePhotoState>(
        listener: (context, state) {
          if (state is ProfilePhotoSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('profile.photo.upload_success'.tr()),
                backgroundColor: Colors.green,
              ),
            );
            context.go(AppRoutes.home);
          } else if (state is ProfilePhotoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'profile.photo.title'.tr(),
              style: const TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 48),
                          child: AuthHeader(
                            title: "profile.photo.upload_title",
                            description: "profile.photo.description",
                          ),
                        ),
                        const PhotoSelectionButton(),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      BlocBuilder<ProfilePhotoBloc, ProfilePhotoState>(
                        builder: (context, state) {
                          return PrimaryButton(
                            text: 'profile.photo.continue'.tr(),
                            isLoading: state is ProfilePhotoLoading,
                            onPressed: state.selectedImage != null
                                ? () {
                                    context.read<ProfilePhotoBloc>().add(
                                      ProfilePhotoUploaded(
                                        photoFile: state.selectedImage!,
                                        context: context,
                                      ),
                                    );
                                  }
                                : null,
                          );
                        },
                      ),
                      if (!widget.fromProfile) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: TextButton(
                            onPressed: _showSkipDialog,
                            child: Text(
                              'profile.photo.skip'.tr(),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSkipDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'profile.photo.skip_title'.tr(),
            style: const TextStyle(color: Colors.white),
          ),
          content: Text(
            'profile.photo.skip_message'.tr(),
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'common.cancel'.tr(),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go(AppRoutes.home);
              },
              child: Text(
                'profile.photo.skip_confirm'.tr(),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
