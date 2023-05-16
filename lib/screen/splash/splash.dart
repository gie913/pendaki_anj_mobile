import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/locator.dart';
import 'package:pendaki_champion/base/paths.dart';
import 'package:pendaki_champion/base/routes.dart';
import 'package:pendaki_champion/database/service/navigator_service.dart';
import 'package:pendaki_champion/manager/storage_manager.dart';
import 'package:pendaki_champion/service/dialog_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NavigatorService _navigationService = locator<NavigatorService>();

  NavigatorService get navigationService => _navigationService;

  DialogService _dialogService = locator<DialogService>();

  DialogService get dialogService => _dialogService;

  MaskFilter? _blur;

  @override
  void initState() {
    autoLogIn();
    Permission.location.request();
    super.initState();
  }

  void autoLogIn() async {
    var duration = const Duration(seconds: 3);
    String? token = await StorageManager.readData("userToken");
    Timer(duration, () {
      if (token != null) {
        _navigationService.push(Routes.HOME_PAGE);
      } else {
        _navigationService.push(Routes.LOGIN_PAGE);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 200),
                SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      Image.asset(
                        Paths.imageLogo,
                        height: 200,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 260,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: WaveWidget(
                    config: CustomConfig(
                      colors: [
                        Colors.green[900]!,
                        Colors.green[800]!,
                        Colors.green[700]!,
                        Colors.green[500]!
                      ],
                      durations: [18000, 8000, 5000, 12000],
                      heightPercentages: [0.85, 0.86, 0.88, 0.90],
                      blur: _blur,
                    ),
                    backgroundColor: Colors.transparent,
                    size: const Size(double.infinity, double.infinity),
                    waveAmplitude: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
