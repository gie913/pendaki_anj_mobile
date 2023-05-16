import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/routes.dart';
import 'package:pendaki_champion/model/m_species.dart';
import 'package:pendaki_champion/model/profile.dart';
import 'package:pendaki_champion/model/t_discovery.dart';
import 'package:pendaki_champion/model/t_discovery_image.dart';
import 'package:pendaki_champion/screen/change_password/change_password_page.dart';
import 'package:pendaki_champion/screen/detail/detail_discovery_screen.dart';
import 'package:pendaki_champion/screen/detail/detail_species_screen.dart';
import 'package:pendaki_champion/screen/discovery/discovery_page.dart';
import 'package:pendaki_champion/screen/edit_profile/edit_profile_page.dart';
import 'package:pendaki_champion/screen/form/form_page.dart';
import 'package:pendaki_champion/screen/login/login_page.dart';
import 'package:pendaki_champion/screen/profile/profile_page.dart';
import 'package:pendaki_champion/screen/splash/splash.dart';
import 'package:pendaki_champion/screen/synch/synch_page.dart';
import 'package:pendaki_champion/screen/tab_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.ROOT:
      return MaterialPageRoute(
        builder: (context) => SplashScreen(),
      );
    case Routes.LOGIN_PAGE:
      return MaterialPageRoute(
        builder: (context) => LoginPage(),
      );
    case Routes.HOME_PAGE:
      return MaterialPageRoute(
        builder: (context) => TabPage(),
      );
    case Routes.PROFILE_PAGE:
      return MaterialPageRoute(
        builder: (context) => ProfilePage(),
      );
    case Routes.DETAIL_SPECIES_PAGE:
      MSpecies mSpecies = settings.arguments as MSpecies;
      return MaterialPageRoute(
        builder: (context) => DetailMSpeciesScreen(mSpecies: mSpecies),
      );
    case Routes.DETAIL_DISCOVERY_PAGE:
      List<Object> listObject = settings.arguments as List<Object>;
      TDiscovery tDiscovery = listObject[0] as TDiscovery;
      List<TDiscoveryImage> tDiscoveryImage = listObject[1] as List<TDiscoveryImage>;
      return MaterialPageRoute(
        builder: (context) => DetailTDiscoveryScreen(
            tDiscovery: tDiscovery, tDiscoveryImage: tDiscoveryImage),
      );
    case Routes.DISCOVERY_PAGE:
      return MaterialPageRoute(
        builder: (context) => DiscoveryPage(),
      );
    case Routes.SYNC_PAGE:
      return MaterialPageRoute(
        builder: (context) => SynchPage(),
      );
    case Routes.PASSWORD_PAGE:
      return MaterialPageRoute(
        builder: (context) => ChangePasswordPage(),
      );
    case Routes.FORM_PAGE:
      MSpecies mSpecies = settings.arguments as MSpecies;
      return MaterialPageRoute(
        builder: (context) => FormPage(mSpecies: mSpecies),
      );
    case Routes.EDIT_PROFILE_PAGE:
      Profile profile = settings.arguments as Profile;
      return MaterialPageRoute(
        builder: (context) => EditProfilePage(profile: profile),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('Route not defined'),
          ),
        ),
      );
  }
}
