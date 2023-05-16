import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/api/api_configuration.dart';
import 'package:pendaki_champion/base/api/api_endpoint.dart';
import 'package:pendaki_champion/model/login_response.dart';

class LoginRepository extends APIConfiguration {
  LoginRepository() : super();

  void doPostLogin(BuildContext context, String username, String password,
      onSuccess, onError) async {
    try {
      var url = APIEndpoint.baseUrl + APIEndpoint.signIn;
      var uri = Uri.parse(url);
      var map = new Map<String, dynamic>();
      map['username'] = username;
      map['password'] = password;
      var response = await ioClient!.post(
        uri,
        body: map,
      );
      LoginResponse loginResponse =
          LoginResponse.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        onSuccess(context, loginResponse);
      } else {
        onError(context, loginResponse.message);
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
