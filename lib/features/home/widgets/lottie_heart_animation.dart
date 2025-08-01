import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieHeartAnimation extends StatefulWidget {
  final VoidCallback? onAnimationComplete;

  const LottieHeartAnimation({super.key, this.onAnimationComplete});

  @override
  State<LottieHeartAnimation> createState() => _LottieHeartAnimationState();
}

class _LottieHeartAnimationState extends State<LottieHeartAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete?.call();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/favorite_lottie.json',
        controller: _controller,
        width: 400,
        height: 400,
        fit: BoxFit.contain,
        repeat: false,
        onLoaded: (composition) {
          _controller.forward(from: 0.16);
        },
      ),
    );
  }
}
