import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:pendaki_champion/base/locator.dart';
import 'package:pendaki_champion/base/routes.dart';
import 'package:pendaki_champion/database/service/navigator_service.dart';
import 'package:pendaki_champion/manager/gallery_manager.dart';
import 'package:pendaki_champion/manager/storage_manager.dart';
import 'package:pendaki_champion/model/image_response.dart';
import 'package:pendaki_champion/model/log_out_response.dart';
import 'package:pendaki_champion/model/profile.dart';
import 'package:pendaki_champion/screen/edit_profile/edit_photo_repository.dart';
import 'package:pendaki_champion/screen/edit_profile/edit_profile_repository.dart';
import 'package:pendaki_champion/service/dialog_service.dart';

class EditProfileNotifier extends ChangeNotifier {
  NavigatorService _navigationService = locator<NavigatorService>();

  NavigatorService get navigationService => _navigationService;

  DialogService _dialogService = locator<DialogService>();

  DialogService get dialogService => _dialogService;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController _name = TextEditingController();

  TextEditingController get name => _name;

  TextEditingController _phone = TextEditingController();

  TextEditingController get phone => _phone;

  TextEditingController _email = TextEditingController();

  TextEditingController get email => _email;

  String? _imageUrl;

  String? get imageUrl => _imageUrl;

  String? _imageID;

  String? get imageID => _imageID;

  Profile? _profile;

  Profile? get profile => _profile;

  onInitEditProfile(Profile profile) {
    _name.text = profile.name ?? "";
    _phone.text = profile.phoneNumber ?? "";
    _email.text = profile.email ?? "";
    _imageUrl = profile.imageSrc;
    _profile = profile;
  }

  getImageGallery(BuildContext context) async {
    XFile? file = await GalleryManager.getImage(context);
    String token = await StorageManager.readData("userToken");
    if (file != null) {
      EditPhotoRepository().doUploadPhotoUser(
          context, token, file.path, "user", onSuccessPhoto, onErrorPhoto);
    }
  }

  onSuccessPhoto(BuildContext context, String response) {
    ImageResponse imageResponse = ImageResponse.fromJson(jsonDecode(response));
    _imageUrl = imageResponse.data?.url;
    _imageID = imageResponse.data?.fileId;
    notifyListeners();
  }

  onErrorPhoto(BuildContext context, String response) {
    _dialogService.showNoOptionDialog(
        title: "Change Photo Failed",
        subtitle: "${response}",
        onPress: onPress);
  }

  onPress() {
    _dialogService.popDialog();
  }

  onSaveChangeProfile() {
    if (_formKey.currentState!.validate()) {
      _dialogService.showOptionDialog(
          title: "Change Profile",
          subtitle: "Are you sure want to change profile?",
          buttonTextYes: "Yes",
          buttonTextNo: "No",
          onPressYes: onPressYes,
          onPressNo: onPressNo);
    }
  }

  Future getCamera(BuildContext context) async {
    XFile? file = await GalleryManager.getCamera(context);
    String token = await StorageManager.readData("userToken");
    if (file != null) {
      File rotatedImage = await FlutterExifRotation.rotateImage(path: file.path);
      EditPhotoRepository().doUploadPhotoUser(
          context, token, rotatedImage.path, "user", onSuccessPhoto, onErrorPhoto);
    }
  }

  onPressYes() async {
    _dialogService.popDialog();
    String token = await StorageManager.readData("userToken");
    UpdateProfileRepository().doPostUpdateProfile(
        _navigationService.navigatorKey.currentContext!,
        token,
        _name.text,
        _phone.text,
        _email.text,
        _profile!,
        _imageID,
        onSuccessUpdate,
        onErrorUpdate);
  }

  onSuccessUpdate(BuildContext context, LogOutResponse logOutResponse) {
    _navigationService.push(Routes.HOME_PAGE);
  }

  onErrorUpdate(BuildContext context, String response) {
    _dialogService.showNoOptionDialog(
        title: "Update Profile", subtitle: "$response", onPress: onPressNo);
  }

  onPressNo() {
    _dialogService.popDialog();
  }
}
