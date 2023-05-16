import 'package:flutter/material.dart';
import 'package:pendaki_champion/app.dart';
import 'package:provider/provider.dart';

import 'base/locator.dart';
import 'base/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => ThemeNotifier()),
      ],
      child: App(),
    ),
  );
}
