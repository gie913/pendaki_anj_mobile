import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/locator.dart';
import 'package:pendaki_champion/base/routes.dart';
import 'package:pendaki_champion/database/service/navigator_service.dart';
import 'package:pendaki_champion/manager/storage_manager.dart';
import 'package:pendaki_champion/model/profile.dart';
import 'package:pendaki_champion/model/profile_response.dart';
import 'package:pendaki_champion/screen/login/log_out_notifier.dart';
import 'package:pendaki_champion/screen/profile/profile_repository.dart';
import 'package:pendaki_champion/service/dialog_service.dart';

class ProfileNotifier extends ChangeNotifier {

  NavigatorService _navigationService = locator<NavigatorService>();

  NavigatorService get navigationService => _navigationService;

  DialogService _dialogService = locator<DialogService>();

  DialogService get dialogService => _dialogService;

  bool _loading = true;

  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
  }

  Profile? _profile;

  Profile? get profile => _profile;

  set profile(Profile? profile) {
    _profile = profile;
  }

  onInitUser(BuildContext context, ) async {
    _loading = true;
    String token = await StorageManager.readData("userToken");
    ProfileRepository().getProfile(context, token, onSuccessProfile, onErrorProfile);
  }

  onSuccessProfile(BuildContext context, ProfileResponse profileResponse) {
    _profile = profileResponse.data;
    notifyListeners();
  }

  onErrorProfile(BuildContext context, String response) {
    _loading = false;
    notifyListeners();
  }

  onPressLogOut(BuildContext context) {
    _dialogService.showOptionDialog(title: "Log Out",
        subtitle: "Are you sure want to Log Out?",
        buttonTextYes: "Yes",
        buttonTextNo: "No",
        onPressYes: onPressYes,
        onPressNo: onPressNo);
  }

  onPressResetPassword() {
    _navigationService.push(Routes.PASSWORD_PAGE);
  }

  onPressEditProfile() {
    _navigationService.push(Routes.EDIT_PROFILE_PAGE, arguments: _profile);
  }

  onPressYes() async {
    _dialogService.popDialog();
    String token = await StorageManager.readData("userToken");
    LogOutNotifier().doLogOut(_navigationService.navigatorKey.currentContext!, token);
  }

  onPressNo() {
  _dialogService.popDialog();
  }
}
