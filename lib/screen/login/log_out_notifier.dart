import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/locator.dart';
import 'package:pendaki_champion/base/routes.dart';
import 'package:pendaki_champion/database/service/m_species_service.dart';
import 'package:pendaki_champion/database/service/navigator_service.dart';
import 'package:pendaki_champion/database/service/t_discovery_service.dart';
import 'package:pendaki_champion/database/service/user_service.dart';
import 'package:pendaki_champion/manager/storage_manager.dart';
import 'package:pendaki_champion/model/log_out_response.dart';
import 'package:pendaki_champion/model/t_discovery.dart';
import 'package:pendaki_champion/screen/login/log_out_repository.dart';
import 'package:pendaki_champion/service/dialog_service.dart';

class LogOutNotifier extends ChangeNotifier {
  NavigatorService _navigationService = locator<NavigatorService>();

  NavigatorService get navigationService => _navigationService;

  DialogService _dialogService = locator<DialogService>();

  DialogService get dialogService => _dialogService;

  doLogOut(BuildContext context, String userToken) async {
    List<TDiscovery> list = await TDiscoveryService().selectTDiscovery();
    if (list.isNotEmpty) {
      _dialogService.showNoOptionDialog(
          title: "Data Found",
          subtitle: "There is data found not uploaded yet",
          onPress: onPressDialog);
    } else {
      _dialogService.showLoadingDialog(title: "Logging Out..");
      LogOutRepository()
          .logOut(context, userToken, onSuccessLogOut, onErrorLogOut);
    }
  }

  onSuccessLogOut(BuildContext context, LogOutResponse logOutResponse) {
    _dialogService.popDialog();
    MSpeciesService().deleteMSpecies();
    UserService().deleteUser();
    StorageManager.deleteData("userToken");
    _navigationService.push(Routes.LOGIN_PAGE);
  }

  onErrorLogOut(BuildContext context, String response) {
    _dialogService.showNoOptionDialog(
        title: "Log Out Gagal", subtitle: response, onPress: onPressDialog);
  }

  onPressDialog() {
    _dialogService.popDialog();
  }
}
