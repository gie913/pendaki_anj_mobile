import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/api/api_configuration.dart';
import 'package:pendaki_champion/base/api/api_endpoint.dart';
import 'package:pendaki_champion/model/log_out_response.dart';

class ChangePasswordRepository extends APIConfiguration {
  ChangePasswordRepository() : super();

  void doPostChangePassword(BuildContext context, String token, String newPassword,
      String confirmPassword, String oldPassword, onSuccess, onError) async {
    try {
      var url = APIEndpoint.baseUrl + APIEndpoint.changePassword;
      var uri = Uri.parse(url);
      var map = new Map<String, dynamic>();
      map['new_password'] = newPassword;
      map['confirm_password'] = confirmPassword;
      map['old_password'] = oldPassword;
      var response = await ioClient!.post(
        uri,
        body: map,
        headers: getDefaultHeaderWithToken(token)
      );
      LogOutResponse changeResponse =
          LogOutResponse.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
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
