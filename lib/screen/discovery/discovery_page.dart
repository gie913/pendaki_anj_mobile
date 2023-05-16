import 'package:flutter/material.dart';
import 'package:pendaki_champion/screen/discovery/discovery_notifier.dart';
import 'package:pendaki_champion/screen/discovery/discovery_screen.dart';
import 'package:provider/provider.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({Key? key}) : super(key: key);

  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DiscoveryNotifier(),
      child: const DiscoveryScreen(
        title: "My Discovery",
      ),
    );
  }
}
