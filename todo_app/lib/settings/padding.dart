import 'package:flutter/material.dart';

import 'responsive.dart';

paddingMain(BuildContext context) {
  return !Responsive.isMobile(context) ? 36.0 : 16.0;
}

class MainPadding extends StatelessWidget {
  final Widget child;
  const MainPadding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingMain(context)),
      child: child,
    );
  }
}

class FormFieldDesktopPadding extends StatelessWidget {
  final Widget child;
  const FormFieldDesktopPadding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: !Responsive.isMobile(context) ? 600.0 : MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }
}
