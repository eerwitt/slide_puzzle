// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/theme/widgets/puzzle_name.dart';
import 'package:very_good_slide_puzzle/theme/widgets/puzzle_title.dart';

/// View for when we're doing server connections
class SlideIslandConnecting extends StatelessWidget {
  const SlideIslandConnecting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              PuzzleTitle(
                title: 'Slide Island Royal',
              ),
              Text(
                'Connecting to server',
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
