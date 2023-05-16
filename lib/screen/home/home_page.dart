import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/strings.dart';
import 'package:pendaki_champion/screen/home/home_notifier.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeNotifier(),
      child: const HomeScreen(
        title: Strings.appName,
      ),
    );
  }
}
