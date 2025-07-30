import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  final double spacing;
  const SocialButtons({super.key, this.spacing = 10});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _mockSocialButton(Icons.g_mobiledata_outlined, iconSize: 40),
        SizedBox(width: spacing),
        _mockSocialButton(Icons.apple_outlined),
        SizedBox(width: spacing),
        _mockSocialButton(Icons.facebook_outlined),
      ],
    );
  }

  Widget _mockSocialButton(IconData icon, {double iconSize = 30}) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(18),
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.1),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Icon(icon, color: Colors.white, size: iconSize),
        ),
      ),
    );
  }
}
