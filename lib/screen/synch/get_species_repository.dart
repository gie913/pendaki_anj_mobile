import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:pendaki_champion/base/api/api_configuration.dart';
import 'package:pendaki_champion/base/api/api_endpoint.dart';
import 'package:pendaki_champion/model/species_response.dart';

class GetSpeciesRepository extends APIConfiguration {
  getSpecies(BuildContext context, String userToken, onSuccess, onError) async {
    try {
      var url = APIEndpoint.baseUrl + APIEndpoint.getSpecies;
      var uri = Uri.parse(url);

      var response = await ioClient!
          .get(uri, headers: getDefaultHeaderWithToken(userToken));

      SpeciesResponse speciesResponse =
          SpeciesResponse.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        onSuccess(context, speciesResponse);
      } else {
        onError(context, speciesResponse.message);
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
