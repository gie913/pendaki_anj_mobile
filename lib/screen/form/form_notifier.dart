import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:pendaki_champion/base/locator.dart';
import 'package:pendaki_champion/database/service/navigator_service.dart';
import 'package:pendaki_champion/database/service/t_discovery_image_service.dart';
import 'package:pendaki_champion/database/service/t_discovery_service.dart';
import 'package:pendaki_champion/database/service/user_service.dart';
import 'package:pendaki_champion/manager/gallery_manager.dart';
import 'package:pendaki_champion/manager/location_manager.dart';
import 'package:pendaki_champion/manager/storage_manager.dart';
import 'package:pendaki_champion/manager/value_manager.dart';
import 'package:pendaki_champion/model/area_group.dart';
import 'package:pendaki_champion/model/m_species.dart';
import 'package:pendaki_champion/model/t_discovery.dart';
import 'package:pendaki_champion/model/t_discovery_image.dart';
import 'package:pendaki_champion/model/user.dart';
import 'package:pendaki_champion/service/dialog_service.dart';

class FormNotifier extends ChangeNotifier {
  NavigatorService _navigationService = locator<NavigatorService>();

  NavigatorService get navigationService => _navigationService;

  DialogService _dialogService = locator<DialogService>();

  DialogService get dialogService => _dialogService;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  TDiscovery _tDiscovery = TDiscovery();

  TDiscovery get tDiscovery => _tDiscovery;

  String? _selectedDate;

  String? get selectedDate => _selectedDate;

  set selectedDate(String? selectedDate) {
    _selectedDate = selectedDate;
  }

  set tDiscovery(TDiscovery tDiscovery) {
    _tDiscovery = tDiscovery;
  }

  String? _deleteImage;

  String? get deleteImage => _deleteImage;

  set deleteImage(String? deleteImage) {
    _deleteImage = deleteImage;
  }

  TextEditingController _totalCount = TextEditingController();

  TextEditingController get totalCount => _totalCount;

  TextEditingController _description = TextEditingController();

  TextEditingController get description => _description;

  TextEditingController _area = TextEditingController();

  TextEditingController get area => _area;

  TextEditingController _distance = TextEditingController();

  TextEditingController get distance => _distance;

  Position? _position;

  Position? get position => _position;

  bool _loading = true;

  bool get loading => _loading;

  String? _pickedFile;

  String? get pickedFile => _pickedFile;

  List<String> _pathPhoto = [];

  List<String> get pathPhoto => _pathPhoto;

  List<AreaGroup> _listAreaGroup = [];

  List<AreaGroup> get listAreaGroup => _listAreaGroup;

  AreaGroup? _areaGroup;

  AreaGroup? get areaGroup => _areaGroup;

  set listAreaGroup(List<AreaGroup> listAreaGroup) {
    _listAreaGroup = listAreaGroup;
  }

  set pathPhoto(List<String> pathPhoto) {
    _pathPhoto = pathPhoto;
  }

  set loading(bool loading) {
    _loading = loading;
  }

  set position(Position? position) {
    _position = position;
  }

  set input(TextEditingController input) {
    _totalCount = input;
  }

  onInit(MSpecies mSpecies) {
    getLocation();
    generateTDiscovery(mSpecies);
    _totalCount.text = "1";
  }

  getLocation() {
    LocationManager.getGPSLocation().then((value) {
      _position = value;
      _tDiscovery.gpsLng = _position?.longitude;
      _tDiscovery.gpsLat = _position?.latitude;
      _loading = false;
      notifyListeners();
    });
  }

  generateTDiscovery(MSpecies mSpecies) async {
    DateTime now = DateTime.now();
    List<User> user = await UserService().selectUser();
    TDiscovery tDiscovery =
        TDiscovery.fromJson(jsonDecode(jsonEncode(mSpecies)));
    _tDiscovery = tDiscovery;
    _tDiscovery.mSpeciesId = mSpecies.id;
    _tDiscovery.id = "${user[0].companyCode}" +
        "M" +
        ValueManager.generateIDFromDateTime(now);
    _tDiscovery.createdBy = user[0].id;
    _tDiscovery.createdAt = now.toString();
    String areaGroupString = await StorageManager.readData("areaGroup");
    List<dynamic> listAreaGroupTemp = jsonDecode(areaGroupString);
    _selectedDate = DateFormat('yyyy-MM-dd').format(now);
    for (int i = 0; i < listAreaGroupTemp.length; i++) {
      Map<String, dynamic> listMap = listAreaGroupTemp[i];
      AreaGroup areaGroup = AreaGroup.fromJson(listMap);
      _listAreaGroup.add(areaGroup);
    }
    _areaGroup = _listAreaGroup[0];
    notifyListeners();
  }

  increment(int i) {
    int j = int.parse(_totalCount.text) + i;
    _totalCount.text = j.toString();
    notifyListeners();
  }

  decrement(int i) {
    int j = int.parse(_totalCount.text) - i;
    if (j >= 1) {
      _totalCount.text = j.toString();
    }
    notifyListeners();
  }

  Future getCamera(BuildContext context) async {
    XFile? picked = await GalleryManager.getCamera(context);
    if (picked != null) {
      _pickedFile = picked.path;
      _pathPhoto.add(picked.path);
      notifyListeners();
    }
  }

  Future getGallery(BuildContext context) async {
    XFile? picked = await GalleryManager.getImage(context);
    if (picked != null) {
      _pickedFile = picked.path;
      _pathPhoto.add(picked.path);
      notifyListeners();
    }
  }

  onPressDeleteImage(String deleted) {
    _deleteImage = deleted;
    _dialogService.showOptionDialog(
        title: "Delete Image",
        subtitle: "Are you sure want to delete?",
        buttonTextYes: "Yes",
        buttonTextNo: "No",
        onPressYes: onPressYesDeleteImage,
        onPressNo: onPressNo);
  }

  onPressSave() async {
    if(_selectedDate != null) {
      if (_formKey.currentState!.validate()) {
        _dialogService.showOptionDialog(
            title: "Save Discovery",
            subtitle: "Are you sure to save this discovery?",
            buttonTextYes: "Yes",
            buttonTextNo: "No",
            onPressYes: onPressYes,
            onPressNo: onPressNo);
      }
    } else {
      _dialogService.showNoOptionDialog(
          title: "Save Discovery Failed",
          subtitle: "Date Found is not set",
          onPress: onPressNo);
    }
  }

  onChangeAreaGroup(AreaGroup areaGroup) {
    _areaGroup = areaGroup;
    notifyListeners();
  }

  onPressYes() async {
    _dialogService.popDialog();
    _tDiscovery.totalFound = int.parse(_totalCount.text);
    _tDiscovery.description = _description.text;
    _tDiscovery.dateFound = _selectedDate;
    _tDiscovery.areaGroup = _areaGroup!.listData;
    _tDiscovery.distanceEstimation = int.parse(_distance.text);
    _tDiscovery.area = _area.text;
    _tDiscovery.observerActivity = "Pendaki Champion";
    int saved = await TDiscoveryService().insertTDiscovery(_tDiscovery);
    if (saved > 0) {
      for (int i = 0; i < _pathPhoto.length; i++) {
        TDiscoveryImage tDiscoveryImage = TDiscoveryImage();
        tDiscoveryImage.id = "${_tDiscovery.id} ${i}";
        tDiscoveryImage.name = "image";
        tDiscoveryImage.tDiscoveryId = _tDiscovery.id;
        tDiscoveryImage.url = _pathPhoto[i];
        await TDiscoveryImageService().insertTDiscoveryImage(tDiscoveryImage);
      }
      _navigationService.pop();
    } else {
      _dialogService.showNoOptionDialog(
          title: "Save Discovery Failed",
          subtitle: "Make sure your data is complete",
          onPress: onPressNo);
    }
  }

  onPressNo() {
    _dialogService.popDialog();
  }

  onChangeDate(DateTime date) {
    _selectedDate = DateFormat('yyyy-MM-dd').format(date);
    print(_selectedDate);
    notifyListeners();
  }

  onPressYesDeleteImage() {
    _pathPhoto.remove(_deleteImage);
    _dialogService.popDialog();
    notifyListeners();
  }
}
