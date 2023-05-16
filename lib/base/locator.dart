import 'package:get_it/get_it.dart';
import 'package:pendaki_champion/database/service/navigator_service.dart';
import 'package:pendaki_champion/service/dialog_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator
    ..registerLazySingleton<NavigatorService>(() => NavigatorService())
    ..registerLazySingleton<DialogService>(() => DialogService());
}
