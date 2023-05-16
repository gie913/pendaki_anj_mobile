
import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/locator.dart';
import 'package:pendaki_champion/service/dialog_service.dart';
import 'package:pendaki_champion/widget/loading_dialog.dart';
import 'package:pendaki_champion/widget/no_option_dialog.dart';
import 'package:pendaki_champion/widget/option_dialog.dart';

Widget builderDialog(BuildContext context, Widget? widget) =>
    Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(
            builder: (context) =>
                DialogManager(
                  child: widget,
                ),
          ),
    );

class DialogManager extends StatefulWidget {
  final Widget? child;

  DialogManager({
    Key? key,
    required this.child,
  }) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(
      _showNoOptionDialog,
      _showOptionDialog,
      _showLoadingDialog,
      _popDialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }

  void _showNoOptionDialog(NoOptionDialogRequest request) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          NoOptionDialog(
            title: request.title,
            subtitle: request.subtitle,
            onPress: request.onPress,
            buttonText: 'OK',
          ),
    );
  }

  void _showOptionDialog(OptionDialogRequest request) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          OptionDialog(
            title: request.title,
            subtitle: request.subtitle,
            buttonTextNo: request.buttonTextNo,
            buttonTextYes: request.buttonTextYes,
            onPressYes: request.onPressYes,
            onPressNo: request.onPressNo,
          ),
    );
  }

  void _showLoadingDialog(LoadingDialogRequest request) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          LoadingDialog(
            title: request.title,
          ),
    );
  }

  void _popDialog() {
    Navigator.of(context).pop();
  }
}
