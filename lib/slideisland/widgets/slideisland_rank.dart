// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class AnimatedBar extends AnimatedWidget {
  const AnimatedBar({
    Key? key,
    required AnimationController controller,
  }) : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    const progressWidth = 400.0;
    const progressHeight = 10.0;

    return Stack(
      children: [
        // All Safe Players
        Container(
          height: progressHeight,
          width: progressWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.5, color: Colors.black12),
          ),
        ),
        // To cut
        Container(
          height: progressHeight,
          width: progressWidth / 2,
          decoration: const BoxDecoration(color: Colors.grey),
        ),
        // Player
        Transform.translate(
          offset:
              Offset(progressWidth - (_progress.value * progressWidth / 10), 0),
          child: Container(
            height: progressHeight,
            width: progressWidth / 100,
            decoration: const BoxDecoration(color: Color(0xFFFFD700)),
          ),
        ),
      ],
    );
  }
}

class SlideIslandPlayerPosition extends StatefulWidget {
  const SlideIslandPlayerPosition({Key? key}) : super(key: key);

  @override
  State<SlideIslandPlayerPosition> createState() =>
      _SlideIslandPlayerPositionState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _SlideIslandPlayerPositionState extends State<SlideIslandPlayerPosition>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBar(controller: _controller);
  }
}
