import 'package:flutter/material.dart';
import 'package:pendaki_champion/screen/login/login_notifier.dart';
import 'package:pendaki_champion/screen/login/login_screen.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginNotifier(),
      child: const LoginScreen(),
    );
  }
}
