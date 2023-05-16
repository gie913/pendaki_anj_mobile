import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:pendaki_champion/base/paths.dart';
import 'package:pendaki_champion/base/strings.dart';
import 'package:pendaki_champion/base/styles.dart';
import 'package:pendaki_champion/screen/login/login_notifier.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(builder: (context, notifier, child) {
      return WillPopScope(
        onWillPop: () async => false,
        child: MediaQuery(
          data: Styles.mediaQueryText(context),
          child: Scaffold(
            body: Form(
              key: notifier.formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        Paths.imageLogo,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 55),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: notifier.username,
                              autocorrect: false,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                  hintText: Strings.username,
                                  labelText: Strings.username),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return Strings.usernameEmpty;
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: notifier.password,
                              autocorrect: false,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: notifier.obscureText,
                              decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                      onTap: notifier.toggle,
                                      child: notifier.obscureText
                                          ? const Icon(Elusive.eye)
                                          : const Icon(Elusive.eye_off)),
                                  hintText: Strings.password,
                                  labelText: Strings.password),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return Strings.passwordEmpty;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: InkWell(
                                onTap: () {
                                  notifier.doLogin(context);
                                },
                                child: Card(
                                  color: Colors.green[200],
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(14),
                                    child: const Text(
                                      Strings.login,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 60),
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    Strings.appVersion,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: const Text(
                                      Strings.poweredBy,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
