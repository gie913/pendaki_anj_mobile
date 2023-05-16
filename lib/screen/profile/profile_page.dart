import 'package:flutter/material.dart';
import 'package:pendaki_champion/screen/profile/profile_notifier.dart';
import 'package:pendaki_champion/screen/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileNotifier(),
      child: const ProfileScreen(),
    );
  }
}
