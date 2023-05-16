import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/locator.dart';
import 'package:pendaki_champion/base/routes.dart';
import 'package:pendaki_champion/database/service/navigator_service.dart';
import 'package:pendaki_champion/database/service/user_service.dart';
import 'package:pendaki_champion/manager/storage_manager.dart';
import 'package:pendaki_champion/model/login_response.dart';
import 'package:pendaki_champion/screen/login/login_repository.dart';
import 'package:pendaki_champion/service/dialog_service.dart';

class LoginNotifier extends ChangeNotifier {
  NavigatorService _navigationService = locator<NavigatorService>();

  NavigatorService get navigationService => _navigationService;

  DialogService _dialogService = locator<DialogService>();

  DialogService get dialogService => _dialogService;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  bool _obscureText = false;

  bool get obscureText => _obscureText;

  final TextEditingController _username = TextEditingController();

  TextEditingController get username => _username;

  final TextEditingController _password = TextEditingController();

  TextEditingController get password => _password;

  void toggle() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  doLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _dialogService.showLoadingDialog(title: "Please Wait");
      LoginRepository().doPostLogin(context, _username.text, _password.text,
          onSuccessLogin, onErrorLogin);
    }
  }

  onSuccessLogin(BuildContext context, LoginResponse loginResponse) {
    StorageManager.saveData("userToken", loginResponse.data!.token);
    insertUser(context, loginResponse);
  }

  insertUser(BuildContext context, LoginResponse loginResponse) async {
    int i = await UserService().insertUser(loginResponse.data!.user!);
    if (i > 0) {
      _dialogService.popDialog();
      _navigationService.push(Routes.SYNC_PAGE);
    } else {
      _dialogService.showNoOptionDialog(
          title: "Login",
          subtitle: "Gagal menyimpan user",
          onPress: onPressDialog);
    }
  }

  onErrorLogin(BuildContext context, String response) {
    _dialogService.popDialog();
    _dialogService.showNoOptionDialog(
        title: "Login", subtitle: response, onPress: onPressDialog);
  }

  onPressDialog() {
    _dialogService.popDialog();
  }
}
