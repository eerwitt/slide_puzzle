// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_bloc.dart';
import 'package:very_good_slide_puzzle/slideisland/themes/slideisland_theme.dart';
import 'package:very_good_slide_puzzle/slideisland/widgets/display_slide.dart';
import 'package:very_good_slide_puzzle/theme/bloc/theme_bloc.dart';

/// View for when we're doing server connections
class SlideIslandPreGame extends StatelessWidget {
  const SlideIslandPreGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme)
        as SlideIslandTheme;
    final currentRound =
        context.select((ServerSyncBloc bloc) => bloc.state.currentRound);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            const Text(
              'Slide tiles into place until the puzzle is complete.',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      width: 300,
                      decoration: const BoxDecoration(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 25,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 10,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 25,
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 25,
                            alignment: const Alignment(1.2, 0),
                            child: Container(
                              height: 25,
                              width: 25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black54),
                              ),
                              child: const Text('1'),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 25,
                            alignment: const Alignment(1.2, 0),
                            child: Container(
                              height: 25,
                              width: 25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black54),
                              ),
                              child: const Text('2'),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 25,
                            alignment: const Alignment(1.2, 0),
                            child: const RoundNumberAnim(child: Text('3')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 500,
              child: DisplaySlideWidget(
                child: Image.asset(
                  theme.assetForRoundComplete(currentRound),
                  semanticLabel: 'Round Complete Test',
                  fit: BoxFit.fill,
                  height: 500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class RoundNumberAnim extends StatefulWidget {
  const RoundNumberAnim({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  RoundNumberAnimState createState() => RoundNumberAnimState();
}

class RoundNumberAnimState extends State<RoundNumberAnim>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation _colorTween;
  late final Widget _child;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _colorTween = ColorTween(begin: Colors.white, end: Colors.orange).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.2,
          1,
          curve: Curves.ease,
        ),
      ),
    );

    _child = widget.child;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();

    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) => Container(
        height: 25, //_height.value,
        width: 25, //_width.value,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _colorTween.value as Color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black54),
        ),
        child: _child,
      ),
    );
  }
}
