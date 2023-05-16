import 'package:flutter/material.dart';
import 'package:pendaki_champion/screen/synch/synch_notifier.dart';
import 'package:pendaki_champion/screen/synch/synch_screen.dart';
import 'package:provider/provider.dart';

class SynchPage extends StatefulWidget {
  const SynchPage({Key? key}) : super(key: key);

  @override
  _SynchPageState createState() => _SynchPageState();
}

class _SynchPageState extends State<SynchPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SynchNotifier(), child: SynchScreen());
  }
}
