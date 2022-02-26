// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class DisplaySlideWidget extends StatefulWidget {
  const DisplaySlideWidget({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  State<DisplaySlideWidget> createState() => _DisplaySlideWidgetState();
}

class _DisplaySlideWidgetState extends State<DisplaySlideWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1, 0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}
