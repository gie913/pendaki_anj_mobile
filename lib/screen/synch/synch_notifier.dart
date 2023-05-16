import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/locator.dart';
import 'package:pendaki_champion/base/routes.dart';
import 'package:pendaki_champion/database/service/m_species_service.dart';
import 'package:pendaki_champion/database/service/navigator_service.dart';
import 'package:pendaki_champion/manager/storage_manager.dart';
import 'package:pendaki_champion/model/species_response.dart';
import 'package:pendaki_champion/screen/login/log_out_notifier.dart';
import 'package:pendaki_champion/screen/synch/get_group_area_repository.dart';
import 'package:pendaki_champion/screen/synch/get_species_repository.dart';
import 'package:pendaki_champion/service/dialog_service.dart';

class SynchNotifier extends ChangeNotifier {
  NavigatorService _navigationService = locator<NavigatorService>();

  NavigatorService get navigationService => _navigationService;

  DialogService _dialogService = locator<DialogService>();

  DialogService get dialogService => _dialogService;

  doGetSpecies(BuildContext context) async {
    String token = await StorageManager.readData("userToken");
    GetSpeciesRepository()
        .getSpecies(context, token, onSuccessGetSpecies, onErrorGetSpecies);
  }

  onSuccessGetSpecies(
      BuildContext context, SpeciesResponse speciesResponse) async {
    int i = await MSpeciesService().insertMSpecies(speciesResponse.data!);
    if (i > 0) {
      GetGroupAreaRepository().getGroupArea(context, onSuccess, onError);
      _navigationService.push(Routes.HOME_PAGE);
    } else {
      _dialogService.showNoOptionDialog(
          title: "Species Data Empty",
          subtitle: "Nothing to insert to Table",
          onPress: onPressOK);
    }
  }

  onSuccess(BuildContext context, response) {
    print(response);
  }

  onError(BuildContext context, String response) {
    print(response);
  }

  onPressOK() async {
    _dialogService.popDialog();
    String token = await StorageManager.readData("userToken");
    LogOutNotifier().doLogOut(_navigationService.navigatorKey.currentContext!, token);
  }

  onErrorGetSpecies(BuildContext context, String response) {
    _dialogService.showNoOptionDialog(
        title: "Get Species Failed", subtitle: response, onPress: null);
  }
}
