import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/api/api_configuration.dart';
import 'package:pendaki_champion/base/api/api_endpoint.dart';
import 'package:pendaki_champion/manager/storage_manager.dart';

class GetGroupAreaRepository extends APIConfiguration {
  getGroupArea(
      BuildContext context, onSuccess, onError) async {
    try {
      var url = APIEndpoint.baseUrl + APIEndpoint.getGroupArea;
      var uri = Uri.parse(url);

      var response = await ioClient!.get(uri);
      if (response.statusCode == 200) {
        StorageManager.saveData("areaGroup", response.body);
        onSuccess(context, response);
      } else {
        onError(context, response.toString());
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
