import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/api/api_configuration.dart';
import 'package:pendaki_champion/base/api/api_endpoint.dart';
import 'package:pendaki_champion/model/log_out_response.dart';
import 'package:pendaki_champion/model/profile.dart';

class UpdateProfileRepository extends APIConfiguration {
  UpdateProfileRepository() : super();

  void doPostUpdateProfile(BuildContext context, String token, String name,
      String phone, String email, Profile profile, String? image, onSuccess, onError) async {
    try {
      var url = APIEndpoint.baseUrl + APIEndpoint.updateProfile;
      var uri = Uri.parse(url);
      var map = new Map<String, dynamic>();
      map['name'] = name;
      map['phone'] = phone;
      map['email'] = email;
      map['job_code'] = profile.observer?.jobCode;
      if(image != null) {
        map['image'] = image;
      } else {
        map['image'] = '';
      }
      var response = await ioClient!.post(
          uri,
          body: jsonEncode(map),
          headers: getDefaultHeaderWithTokens(token)
      );
      LogOutResponse changeResponse =
      LogOutResponse.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        print(response.body);
        onSuccess(context, changeResponse);
      } else {
        onError(context, changeResponse.message);
      }
    } on SocketException {
      onError(context, 'Tidak Ada Koneksi Internet');
    } on HttpException {
      onError(context, 'No Service Found');
    } on FormatException {
      onError(context, 'Response Format Gagal');
    } catch (exception) {
      onError(context, exception.toString());
    }
  }
}
