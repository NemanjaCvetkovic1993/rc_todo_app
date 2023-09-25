import 'package:flutter/material.dart';

const int tabletScreenSize = 1000;
const int mobileScreenSize = 650;

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < mobileScreenSize;

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= mobileScreenSize && MediaQuery.of(context).size.width < tabletScreenSize;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= tabletScreenSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= tabletScreenSize) {
          return desktop;
        } else if (constraints.maxWidth >= mobileScreenSize) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
