// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/*
    return Container(
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          AnimatedProgressBar(
            key: const Key('slide_island_progress_bar'),
            animation: _progressAnimation,
          ),
          Expanded(
            child: Container(
              height: 6,
              width: 100, // double.infinity,
              decoration: const BoxDecoration(color: Colors.cyanAccent),
            ),
            */

class AnimatedBar extends AnimatedWidget {
  const AnimatedBar({
    Key? key,
    required AnimationController controller,
  }) : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: _progress.value * 10,
      decoration: const BoxDecoration(color: Colors.deepOrange),
    );
    /*return Transform.scale(
        scale: _progress.value,
        child: Container(width: 100, height: 100, color: Colors.lightGreen));
        */
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
