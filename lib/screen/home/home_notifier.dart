import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/locator.dart';
import 'package:pendaki_champion/base/routes.dart';
import 'package:pendaki_champion/database/service/m_species_service.dart';
import 'package:pendaki_champion/database/service/navigator_service.dart';
import 'package:pendaki_champion/manager/storage_manager.dart';
import 'package:pendaki_champion/model/m_species.dart';
import 'package:pendaki_champion/model/t_discovery.dart';
import 'package:pendaki_champion/model/t_discovery_image.dart';
import 'package:pendaki_champion/screen/home/home_screen.dart';
import 'package:pendaki_champion/screen/profile/profile_page.dart';
import 'package:pendaki_champion/service/dialog_service.dart';

class HomeNotifier extends ChangeNotifier {
  NavigatorService _navigationService = locator<NavigatorService>();

  NavigatorService get navigationService => _navigationService;

  DialogService _dialogService = locator<DialogService>();

  DialogService get dialogService => _dialogService;

  List<MSpecies> _listFauna = [];

  List<MSpecies> get listFauna => _listFauna;

  List<MSpecies> _listFaunaResult = [];

  List<MSpecies> get listFaunaResult => _listFaunaResult;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(title: "Pendaki Champion"),
    ProfilePage()
  ];

  int _selectedIndex = 0;

  int get selectIndex => _selectedIndex;

  List<Widget> get widgetOption => _widgetOptions;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  onInitHome(BuildContext context) async {
    List<MSpecies> listMSpecies = await MSpeciesService().selectMSpecies();
    String token = await StorageManager.readData("userToken");
    print(token);
    if (listMSpecies.isNotEmpty) {
      _listFauna.addAll(listMSpecies);
      _listFaunaResult.addAll(listMSpecies);
      _isLoading = false;
    } else {
      _isLoading = false;
    }
    notifyListeners();
  }

  navigateForm(BuildContext context, MSpecies mSpecies) {
    _navigationService.push(Routes.FORM_PAGE, arguments: mSpecies);
  }

  navigateToList(BuildContext context) {
    _navigationService.push(Routes.DISCOVERY_PAGE);
  }

  navigateDetail(BuildContext context, MSpecies mSpecies) {
    _navigationService.push(Routes.DETAIL_SPECIES_PAGE, arguments: mSpecies);
  }

  navigationDetailTDiscovery(BuildContext context, TDiscovery tDiscovery,
      List<TDiscoveryImage> tDiscoveryImage) {
    _navigationService.push(
        Routes.DETAIL_DISCOVERY_PAGE, arguments: [tDiscovery, tDiscoveryImage]);
  }

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void onChangeSearch(String text) {
    _listFaunaResult.clear();
    if (text.isEmpty) {
      _listFaunaResult.addAll(_listFauna);
    } else {
      _listFauna.forEach((element) {
        if (element.inaName!.toLowerCase().contains(text.toLowerCase()) ||
            element.latinName!.toLowerCase().contains(text.toLowerCase())) {
          _listFaunaResult.add(element);
        }
      });
    }
    notifyListeners();
  }
}
