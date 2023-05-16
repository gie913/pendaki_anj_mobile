import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pendaki_champion/manager/dialog_manager.dart' as dialog;
import 'package:pendaki_champion/manager/routes_manager.dart' as router;
import 'package:pendaki_champion/screen/splash/splash.dart';
import 'package:provider/provider.dart';

import 'base/locator.dart';
import 'base/routes.dart';
import 'base/screen_style.dart';
import 'base/theme_notifier.dart';
import 'database/service/navigator_service.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.getTheme(),
        darkTheme: theme.darkTheme,
        navigatorKey: locator<NavigatorService>().navigatorKey,
        onGenerateRoute: router.generateRoute,
        initialRoute: Routes.ROOT,
        builder: (context, child) {
          child = dialog.builderDialog(context, child);
          child = ScreenStyle.responsiveBuilder(context, child);
          return child;
        },
        home: SplashScreen(),
      ),
    );
  }
}
