// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// View for when we're doing server connections
class SlideIslandLost extends StatelessWidget {
  const SlideIslandLost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: const [
            Text(
              'You Lost :(',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
