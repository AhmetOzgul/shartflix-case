import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  final double spacing;
  const SocialButtons({super.key, this.spacing = 10});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _mockSocialButton(context, Icons.g_mobiledata_outlined, iconSize: 40),
        SizedBox(width: spacing),
        _mockSocialButton(context, Icons.apple_outlined),
        SizedBox(width: spacing),
        _mockSocialButton(context, Icons.facebook_outlined),
      ],
    );
  }

  Widget _mockSocialButton(
    BuildContext context,
    IconData icon, {
    double iconSize = 30,
  }) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(18),
        splashColor: theme.colorScheme.onSurface.withValues(alpha: 0.2),
        highlightColor: theme.colorScheme.onSurface.withValues(alpha: 0.1),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
          ),
          child: Icon(icon, color: theme.colorScheme.onSurface, size: iconSize),
        ),
      ),
    );
  }
}
