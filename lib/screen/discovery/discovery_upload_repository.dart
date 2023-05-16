import 'dart:convert';
import 'dart:io';

import 'package:pendaki_champion/base/api/api_configuration.dart';
import 'package:pendaki_champion/base/api/api_endpoint.dart';
import 'package:pendaki_champion/model/t_discovery.dart';

class UploadDiscoveryRepository extends APIConfiguration {
  void doPostUploadDiscovery(
      String token, List<TDiscovery> listDiscovery, onSuccess, onError) async {
    try {
      var url = APIEndpoint.baseUrl + APIEndpoint.sendDiscovery;
      var uri = Uri.parse(url);
      var mapDiscovery = Map<String, dynamic>();
      mapDiscovery = {'discovery': listDiscovery};

      var response = await ioClient!.post(uri,
          body: jsonEncode(mapDiscovery), headers: getDefaultHeaderWithTokens(token));
      print(response.body);
      if (response.statusCode == 200) {
        onSuccess(response);
      } else {
        onError(response);
      }
    } on SocketException {
      onError('No Internet');
    } on HttpException {
      onError('No Service Found');
    } on FormatException {
      onError('Invalid Response format');
    } catch (exception) {
      onError(exception.toString());
    }
  }
}
