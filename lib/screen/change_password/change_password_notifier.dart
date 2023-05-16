import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/locator.dart';
import 'package:pendaki_champion/database/service/navigator_service.dart';
import 'package:pendaki_champion/manager/storage_manager.dart';
import 'package:pendaki_champion/model/log_out_response.dart';
import 'package:pendaki_champion/screen/profile/change_password_repository.dart';
import 'package:pendaki_champion/service/dialog_service.dart';

class ChangePasswordNotifier extends ChangeNotifier {
  NavigatorService _navigationService = locator<NavigatorService>();

  NavigatorService get navigationService => _navigationService;

  DialogService _dialogService = locator<DialogService>();

  DialogService get dialogService => _dialogService;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController _newPassword = TextEditingController();

  TextEditingController get newPassword => _newPassword;

  set newPassword(TextEditingController newPassword) {
    _newPassword = newPassword;
  }

  TextEditingController _oldPassword = TextEditingController();

  TextEditingController get oldPassword => _oldPassword;

  set oldPassword(TextEditingController oldPassword) {
    _oldPassword = oldPassword;
  }

  TextEditingController _confirmPassword = TextEditingController();

  TextEditingController get confirmPassword => _confirmPassword;

  set confirmPassword(TextEditingController confirmPassword) {
    _confirmPassword = confirmPassword;
  }

  onPressSaved(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _dialogService.showOptionDialog(
          title: "Change Password",
          subtitle: "Are you sure want to change password?",
          buttonTextYes: "Yes",
          buttonTextNo: "No",
          onPressYes: onPressYes,
          onPressNo: onPressNo);
    }
  }

  onPressYes() async {
    _dialogService.popDialog();
    _dialogService.showLoadingDialog(title: "Please Wait");
    String token = await StorageManager.readData("userToken");
    ChangePasswordRepository().doPostChangePassword(
        _navigationService.navigatorKey.currentContext!,
        token,
        _newPassword.text,
        _confirmPassword.text,
        _oldPassword.text,
        onSuccessChanged,
        onErrorChanged);
  }

  onPressNo() {
    _dialogService.popDialog();
  }

  onSuccessChanged(BuildContext context, LogOutResponse logOutResponse) {
    _dialogService.popDialog();
    _dialogService.showNoOptionDialog(
        title: "Change Password",
        subtitle: logOutResponse.message!,
        onPress: onPressNo);
    _navigationService.pop();
  }

  onErrorChanged(BuildContext context, String response) {
    _dialogService.popDialog();
    _dialogService.showNoOptionDialog(
        title: "Change Password",
        subtitle: response,
        onPress: onPressNo);
  }
}
