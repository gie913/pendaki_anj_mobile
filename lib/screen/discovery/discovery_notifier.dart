import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/locator.dart';
import 'package:pendaki_champion/base/routes.dart';
import 'package:pendaki_champion/database/service/navigator_service.dart';
import 'package:pendaki_champion/database/service/t_discovery_image_service.dart';
import 'package:pendaki_champion/database/service/t_discovery_service.dart';
import 'package:pendaki_champion/manager/storage_manager.dart';
import 'package:pendaki_champion/model/t_discovery.dart';
import 'package:pendaki_champion/model/t_discovery_image.dart';
import 'package:pendaki_champion/screen/discovery/discovery_upload_image_repository.dart';
import 'package:pendaki_champion/screen/discovery/discovery_upload_repository.dart';
import 'package:pendaki_champion/screen/home/home_notifier.dart';
import 'package:pendaki_champion/service/dialog_service.dart';

class DiscoveryNotifier extends ChangeNotifier {
  NavigatorService _navigationService = locator<NavigatorService>();

  NavigatorService get navigationService => _navigationService;

  DialogService _dialogService = locator<DialogService>();

  DialogService get dialogService => _dialogService;

  List<TDiscovery> _listTDiscovery = [];

  List<TDiscovery> get listTDiscovery => _listTDiscovery;

  List<TDiscovery> _listTDiscoveryResult = [];

  List<TDiscovery> get listTDiscoveryResult => _listTDiscoveryResult;

  List<TDiscoveryImage> _listTDiscoveryImage = [];

  List<TDiscoveryImage> get listTDiscoveryImage => _listTDiscoveryImage;

  TDiscovery? _tDiscoveryDeleted;

  TDiscovery? get tDiscoveryDeleted => _tDiscoveryDeleted;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  onInitDiscovery(BuildContext context) async {
    List<TDiscovery> listTDiscoveryTemp = await TDiscoveryService().selectTDiscoveryWithImage();
    List<TDiscoveryImage> listTDiscoveryImageTemp = await TDiscoveryImageService().selectTDiscoveryImage();
    if (listTDiscoveryTemp.isNotEmpty) {
      _listTDiscovery.addAll(listTDiscoveryTemp);
      _listTDiscoveryResult.addAll(listTDiscoveryTemp);
      _listTDiscoveryImage.addAll(listTDiscoveryImageTemp);
      _isLoading = false;
    } else {
      _isLoading = false;
    }
    notifyListeners();
  }

  void onChangeSearch(String text) {
    _listTDiscoveryResult.clear();
    if (text.isEmpty) {
      _listTDiscoveryResult.addAll(_listTDiscovery);
    } else {
      _listTDiscovery.forEach((element) {
        if (element.inaName!.toLowerCase().contains(text.toLowerCase()) ||
            element.latinName!.toLowerCase().contains(text.toLowerCase())) {
          _listTDiscoveryResult.add(element);
        }
      });
    }
    notifyListeners();
  }

  void deleteDiscovery(TDiscovery tDiscovery) async {
    _tDiscoveryDeleted = tDiscovery;
    _dialogService.showOptionDialog(
        title: "Delete Discovery",
        subtitle: "Are you sure want to delete?",
        buttonTextYes: "Yes",
        buttonTextNo: "No",
        onPressYes: onPressYes,
        onPressNo: onPressNo);
  }

  onPressYes() async {
    _dialogService.popDialog();
    int deleted =
        await TDiscoveryService().deleteTDiscoveryByID(_tDiscoveryDeleted!);
    if (deleted > 0) {
      await TDiscoveryImageService()
          .deleteTDiscoveryImageByID(_tDiscoveryDeleted!);
      _listTDiscovery.remove(_tDiscoveryDeleted);
      _listTDiscoveryResult.remove(_tDiscoveryDeleted);
      notifyListeners();
    }
    notifyListeners();
  }

  onPressNo() {
    _dialogService.popDialog();
  }

  doUploadDiscovery() {
    _dialogService.showOptionDialog(
        title: "Upload Discovery",
        subtitle: "Are you sure want to Upload?",
        buttonTextYes: "Yes",
        buttonTextNo: "No",
        onPressYes: onPressYesUpload,
        onPressNo: onPressNo);
  }

  onPressYesUpload() async {
    _dialogService.popDialog();
    _dialogService.showLoadingDialog(title: "Upload Data");
    String token = await StorageManager.readData("userToken");
    UploadDiscoveryRepository().doPostUploadDiscovery(
        token, _listTDiscovery, onSuccessUpload, onErrorUpload);
  }

  onSuccessUpload(response) async {
    try {
      String token = await StorageManager.readData("userToken");
      for (int i = 0; i < _listTDiscoveryImage.length; i++) {
        UploadImageRepository().doUploadPhoto(
            _navigationService.navigatorKey.currentContext!,
            token,
            _listTDiscoveryImage[i].url!,
            "discovery",
            _listTDiscoveryImage[i].tDiscoveryId!,
            onSuccessUploadImage,
            onErrorUploadImage);
      }
      TDiscoveryService().deleteTDiscovery();
      TDiscoveryImageService().deleteTDiscoveryImage();
      _dialogService.popDialog();
      _navigationService.push(Routes.HOME_PAGE);
    } catch (e) {
      _dialogService.showNoOptionDialog(
          title: "Upload Data", subtitle: "Error $e", onPress: onPressNo);
    }
  }

  onErrorUpload(response) {
    print(response);
  }

  onSuccessUploadImage(BuildContext context, response) {
    print(response);
  }

  onErrorUploadImage(BuildContext context, String response) {
    print(response);
  }

  gotoDetailDiscovery(BuildContext context, TDiscovery discovery) {
    List<TDiscoveryImage> listTDiscoveryImage = [];
    _listTDiscoveryImage.forEach((element) {
      if (element.tDiscoveryId == discovery.id) {
        listTDiscoveryImage.add(element);
      }
    });
    HomeNotifier().navigationDetailTDiscovery(context, discovery, listTDiscoveryImage);
  }
}
