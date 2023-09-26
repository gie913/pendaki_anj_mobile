import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ScreenStyle {
  static Widget responsiveBuilder(BuildContext context, Widget? child) =>
      ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      );

  // Responsive size
  static double responsiveSize({
    required BuildContext context,
    required double largeValue,
    required double mediumValue,
    required double smallValue,
    required double verySmallValue,
  }) {
    if (Responsive.isLargeScreen(context)) {
      return largeValue;
    } else if (Responsive.isMediumScreen(context)) {
      return mediumValue;
    } else if (Responsive.isVerySmallScreen(context)) {
      return smallValue;
    } else {
      return verySmallValue;
    }
  }
}

class Responsive extends StatelessWidget {
  final Widget largeScreen;
  final Widget mediumScreen;
  final Widget smallScreen;

  const Responsive(
      {Key? key,
      required this.largeScreen,
      required this.mediumScreen,
      required this.smallScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Returns the widget which is more appropriate for the screen size
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1200) {
        return largeScreen;
      } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
        return mediumScreen;
      } else {
        return smallScreen;
      }
    });
  }

  //Making these methods static, so that they can be used as accessed from other widgets

  //Large screen is any screen whose width is more than 1200 pixels
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }

  //Medium screen is any screen whose width is less than 1200 pixels,
  //and more than 800 pixels
  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 800 &&
        MediaQuery.of(context).size.width < 1200;
  }

  //Small screen is any screen whose width is less than 800 pixels
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  //Very small screen is any screen whose width is less than 800 pixels
  static bool isVerySmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 400;
  }
}

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
