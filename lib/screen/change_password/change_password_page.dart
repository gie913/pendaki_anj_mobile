import 'package:flutter/material.dart';
import 'package:pendaki_champion/screen/change_password/change_password_notifier.dart';
import 'package:pendaki_champion/screen/change_password/change_password_screen.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangePasswordNotifier(),
      child: const ChangePasswordScreen(),
    );
  }
}
