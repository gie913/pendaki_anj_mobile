import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:pendaki_champion/base/api/api_configuration.dart';
import 'package:pendaki_champion/base/api/api_endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class UploadImageRepository extends APIConfiguration {
  void doUploadPhoto(BuildContext context, String token, String image,
      String moduleId, String module, onSuccess, onError) async {
    File imageFile = File(image);
    var stream = http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();
    try {
      var url = APIEndpoint.baseUrl + APIEndpoint.sendImage;
      var uri = Uri.parse(url);

      var mimeContent = lookupMimeType(
          '${imageFile.path.toString().substring(imageFile.path.toString().length - 20)}');
      var typeMedia = mimeContent!.substring(0, mimeContent.indexOf('/', 0));
      var pos = mimeContent.indexOf('/', 0);
      var subTypeMedia = mimeContent.substring(pos + 1, mimeContent.length);
      var multipartFile = http.MultipartFile('image', stream, length,
          filename: basename(imageFile.path),
          contentType: MediaType(typeMedia, subTypeMedia));

      var request = http.MultipartRequest("POST", uri);
      request.headers.addAll(getDefaultHeaderWithTokens(token));
      request.fields['m_module_id'] = moduleId;
      request.fields['m_module_key'] = module;
      request.fields['name'] = "image";
      request.files.add(multipartFile);

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        if (response.statusCode == 200) {
          onSuccess(context, response);
        } else {
          onError(context, response.toString());
        }
      });
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
