import 'package:flutter/material.dart';

import 'mobile_body.dart';
import 'web_body.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 480) {
          return const WebBody();
        } else {
          return const MobileBody();
        }
      }),
    );
  }
}
