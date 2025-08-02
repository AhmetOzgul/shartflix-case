import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shartflix/shared/widgets/primary_button.dart';

class LimitedOfferBottomSheet extends StatelessWidget {
  const LimitedOfferBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
          ),
        ),

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 300,
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.5),
                  radius: 0.9,
                  colors: [
                    Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.5),
                    Colors.transparent,
                  ],
                  stops: const [0, 1],
                ),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 300,
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, 0.8),
                  radius: 0.9,
                  colors: [
                    Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                  stops: const [0, 1],
                ),
              ),
            ),
          ),
        ),

        Positioned.fill(
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildTitleSection(context),
                      const SizedBox(height: 24),
                      _buildBonusesSection(context),
                      const SizedBox(height: 24),
                      _buildTokenPackagesSection(context),
                      const SizedBox(height: 32),
                      PrimaryButton(
                        onPressed: () {},
                        text: 'profile.offer.view_all_tokens'.tr(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'profile.offer.title'.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        SizedBox(height: 8),
        Text(
          'profile.offer.description'.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildBonusesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Text(
            'profile.offer.bonuses_title'.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBonusItem(
                context,
                'bonus1',
                'profile.offer.bonus_premium'.tr(),
              ),
              _buildBonusItem(
                context,
                'bonus2',
                'profile.offer.bonus_matches'.tr(),
              ),
              _buildBonusItem(
                context,
                'bonus3',
                'profile.offer.bonus_highlight'.tr(),
              ),
              _buildBonusItem(
                context,
                'bonus4',
                'profile.offer.bonus_likes'.tr(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBonusItem(BuildContext context, String assetName, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 3,
              colors: [Color(0xFF6F060B), Colors.transparent],
              stops: [0.0, 1],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 1),
                blurRadius: 2,
                spreadRadius: -0.1,
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              'assets/images/$assetName.png',
              width: 36,
              height: 36,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 70,
          child: Text(
            label,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildTokenPackagesSection(BuildContext context) {
    final totalPadding = 20 * 2;
    final spacing = 12 * 2;
    final cardWidth =
        (MediaQuery.of(context).size.width - totalPadding - spacing) / 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'profile.offer.select_package'.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            SizedBox(
              width: cardWidth,
              child: _buildTokenPackage(
                discount: '+10%',
                original: '200',
                current: '330',
                price: 'TL 99,99',
                gradientColors: [Color(0xFFB71C1C), Color(0xFFD32F2F)],
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: cardWidth,
              child: _buildTokenPackage(
                discount: '+70%',
                original: '2.000',
                current: '3.375',
                price: 'TL 799,99',
                gradientColors: [Color(0xFF8E24AA), Color(0xFF3949AB)],
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: cardWidth,
              child: _buildTokenPackage(
                discount: '+35%',
                original: '1.000',
                current: '1.350',
                price: 'TL 399,99',
                gradientColors: [Color(0xFFD84315), Color(0xFFFF5722)],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTokenPackage({
    required String discount,
    required String original,
    required String current,
    required String price,
    required List<Color> gradientColors,
  }) {
    final pillColor = gradientColors.first.withValues(alpha: 0.9);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset.zero,
              ),
              BoxShadow(
                color: gradientColors.first.withValues(alpha: 0.5),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Text(
                original,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Text(
                current,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'profile.offer.token'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Text(
                price,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'profile.offer.price_per_week'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),

        Positioned(
          top: -12,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              decoration: BoxDecoration(
                color: pillColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset.zero,
                  ),
                ],
              ),
              child: Text(
                discount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
