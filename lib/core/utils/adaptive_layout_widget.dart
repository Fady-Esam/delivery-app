import 'package:flutter/material.dart';

class AdaptiveLayoutWidget extends StatelessWidget {
  const AdaptiveLayoutWidget({
    super.key,
    required this.mobileLayout,
    required this.tabletLayout,
  });

  final WidgetBuilder mobileLayout, tabletLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        if (constrains.maxWidth < 600) {
          return mobileLayout(context);
        }  else {
          return tabletLayout(context);
        }
      },
    );
  }
}
