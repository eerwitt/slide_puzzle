// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// View for when we're doing server connections
class SlideIslandConnecting extends StatelessWidget {
  const SlideIslandConnecting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: const [
            Text(
              'Connecting to server',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CircularProgressIndicator(),
          ],
        );
      },
    );
  }
}
