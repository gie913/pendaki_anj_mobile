import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/strings.dart';
import 'package:pendaki_champion/screen/change_password/change_password_notifier.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChangePasswordNotifier>(
        builder: (context, notifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Change Password",  style: TextStyle(fontFamily: "BTTTRIAL")),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.blue.withOpacity(0.2), BlendMode.dstATop),
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: notifier.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: notifier.oldPassword,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        hintText: "Current Password",
                        labelText: "Current Password"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Strings.cannotBeEmpty;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: notifier.newPassword,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        hintText: "New Password", labelText: "New Password"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Strings.cannotBeEmpty;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: notifier.confirmPassword,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        hintText: "Confirm Password",
                        labelText: "Confirm Password"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Strings.cannotBeEmpty;
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      onTap: () {
                        notifier.onPressSaved(context);
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
                            "Save",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
