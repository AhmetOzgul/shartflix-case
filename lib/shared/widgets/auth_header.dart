import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String description;
  final EdgeInsets? padding;

  const AuthHeader({
    super.key,
    required this.title,
    required this.description,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title.tr(),
          style: Theme.of(
            context,
          ).textTheme.displayMedium?.copyWith(fontSize: 18),
        ),
        Padding(
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            description.tr(),
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
