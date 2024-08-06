import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/api/api_configuration.dart';
import 'package:pendaki_champion/base/api/api_endpoint.dart';
import 'package:pendaki_champion/model/profile_response.dart';

class ProfileRepository extends APIConfiguration {
  getProfile(BuildContext context, String userToken, onSuccess, onError) async {
    try {
      var url = APIEndpoint.baseUrl + APIEndpoint.profile;
      var uri = Uri.parse(url);

      var response = await ioClient!
          .get(uri, headers: getDefaultHeaderWithToken(userToken));

      ProfileResponse profileResponse =
          ProfileResponse.fromJson(json.decode(response.body));
      log('url : $url');
      log('token : $userToken');

      log('response : ${json.decode(response.body)}');
      log('profileResponse : $profileResponse');

      if (response.statusCode == 200) {
        onSuccess(context, profileResponse);
      } else {
        onError(context, profileResponse.message);
      }
    } on SocketException {
      onError(context, 'No Internet');
    } on HttpException {
      onError(context, 'No Service Found');
    } on FormatException {
      onError(context, 'Invalid Response format');
    } catch (exception) {
      onError(context, exception.toString());
    }
  }
}
