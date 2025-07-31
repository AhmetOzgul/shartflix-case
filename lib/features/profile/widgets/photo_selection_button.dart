import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_photo_bloc.dart';
import '../bloc/profile_photo_event.dart';
import '../bloc/profile_photo_state.dart';

class PhotoSelectionButton extends StatelessWidget {
  const PhotoSelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePhotoBloc, ProfilePhotoState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<ProfilePhotoBloc>().add(PickImageFromGallery());
          },
          child: Container(
            width: 165,
            height: 165,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.onPrimary.withValues(alpha: 0.1),
                width: 2,
              ),
            ),
            child: state.selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: Image.file(
                      state.selectedImage!,
                      width: 165,
                      height: 165,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.add, color: Colors.white, size: 48),
          ),
        );
      },
    );
  }
}
